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
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
        }
    }
    
    private var realm: Realm = try! Realm()
    var itemList: Results<Item>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList = realm.objects(Item.self)
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
        itemList = realm.objects(Item.self)
        tableView.reloadData()        
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
            itemEditView.initialName = item.name
            itemEditView.setup(mode: ItemEditViewController.Mode.edit(id: item.id))
        }
    }
}

extension ItemListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath)
        guard let itemCell = cell as? ItemCell else { return cell }
        itemCell.configure(name: itemList!.elements[indexPath.row].name, checked: itemList!.elements[indexPath.row].isChecked)
        return itemCell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
                
                let alert = UIAlertController(title: "Delete", message: "Are you sure you want delete ?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive,handler: { (alert) in
                    print("Delete Item at index",indexPath.row)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            item.image = UIImage(named: "deleteIcon")

            let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
            return swipeActions
        }
}

extension ItemListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.ToItemEditVC, sender: itemList![indexPath.row])
    }
}
