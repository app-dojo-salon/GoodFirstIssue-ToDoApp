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
}

class ItemListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // senderがItemのときはitemEditViewに初期値を設定する
        if segue.identifier == Segue.ToItemEditVC, let item = sender as? TempItem {
            configure(itemEditViewContainer: segue.destination, with: item)
        }
    }
    
    @IBAction private func exitDone(segue: UIStoryboardSegue) {
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
    func configure(itemEditViewContainer: UIViewController, with item: TempItem) {
        if let container = itemEditViewContainer as? UINavigationController,
            var itemEditView = container.topViewController as? ItemEditViewProtocol {
            itemEditView.itemId = item.id
            itemEditView.initialName = item.name
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
