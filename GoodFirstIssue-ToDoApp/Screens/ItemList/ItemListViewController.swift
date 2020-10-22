//
//  ItemListViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit
import RealmSwift

protocol ItemEditViewProtocol {
    var itemId: Int? { get set }
    var initialName: String? { get set }
    var itemName: String { get }
    func setup(mode: ItemEditViewController.Mode)
}

class ItemListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ItemCell.loadNib(), forCellReuseIdentifier: ItemCell.reuseIdentifier)
        }
    }
    private var realm: Realm = try! Realm()
    var itemList: [(String)] = []
    var checkedList: [(Bool)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList = realm.objects(Item.self).map(\.name)
        checkedList = realm.objects(Item.self).map(\.isChecked)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        
        if segue.identifier == Segue.ToItemEditVC {
            if let item = sender as? Item {
                // senderがItemのときはitemEditViewに初期値を設定する
                configure(itemEditViewContainer: segue.destination, with: item)
            } else {
                if let container = segue.destination as? UINavigationController,
                    let itemEditView = container.topViewController as? ItemEditViewProtocol {
                    itemEditView.setup(mode: ItemEditViewController.Mode.create)
                }
            }
        }
    }
    
    @IBAction private func exitDone(segue: UIStoryboardSegue) {
        itemList = realm.objects(Item.self).map(\.name)
        checkedList = realm.objects(Item.self).map(\.isChecked)
        tableView.reloadData()

        guard let itemEditView = segue.source as? ItemEditViewProtocol else {
            return
        }
        
        print("itemEditView's id: \(itemEditView.itemId ?? -1), name: \(itemEditView.itemName).")
    }

    @IBAction private func toEditVCTestTapped(_ sender: Any) {
        // TODO: tableViewCellの編集ボタンが呼ばれたら、itemをsenderとしてsegueを実行する
        let tempItem = TempItem(id: 10, name: "Test initial name")
        performSegue(withIdentifier: Segue.ToItemEditVC, sender: tempItem)
    }
}

private extension ItemListViewController {
    enum Segue {
        static let ToItemEditVC = "ToItemEditVC"
    }

    // itemEidtViewのcontainerがNavigationControllerである前提
    func configure(itemEditViewContainer: UIViewController, with item: Item) {
        if let container = itemEditViewContainer as? UINavigationController,
            var itemEditView = container.topViewController as? ItemEditViewProtocol {
            itemEditView.itemId = item.id
            itemEditView.initialName = item.name
            itemEditView.setup(mode: ItemEditViewController.Mode.edit(id: item.id))
        }
    }
}

// TODO: Itemの実装ができたら削除する
private extension ItemListViewController {
    struct TempItem {
        let id: Int
        let name: String
    }
}

extension ItemListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath)
        guard let itemCell = cell as? ItemCell else { return cell }
        itemCell.configure(name: itemList[indexPath.row], checked: checkedList[indexPath.row])
        return itemCell
    }
    
}

extension ItemListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
