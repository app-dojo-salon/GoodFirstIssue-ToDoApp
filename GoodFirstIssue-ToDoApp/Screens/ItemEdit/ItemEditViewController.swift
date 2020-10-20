//
//  ItemEditViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit
import RealmSwift

class ItemEditViewController: UIViewController, ItemEditViewProtocol {
    private var realm: Realm?
    private var mode: Mode!
    
    // MARK: ItemEditViewProtocol

    // 仮のデータ配列（Realmから取得する予定）
    var itemArray: Results<Item>?

    var itemId: Int?
    var initialName: String?
    var itemName: String {
        nameTextField.text ?? ""
    }
    
    // MARK: Implementation
    func setup(mode: Mode) {
        self.mode = mode
    }
    
    @IBOutlet weak private var saveButton: UIBarButtonItem!
    @IBOutlet weak private var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        itemArray = realm!.objects(Item.self)

        switch mode {
        case .create:
            title = "項目追加"
            nameTextField.text = initialName
            break
        case let .edit(item: item):
            title = "項目編集"
            if itemArray!.contains(where: { $0.id == item.id }) {
                nameTextField.text = item.name
                itemId = item.id
            }
            break
        default:
            nameTextField.text = initialName
            break
        }
        nameTextField.delegate = self
        
        saveButton.isEnabled = nameTextField.text != ""
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(tapGesture)
        
        setupBarButtonActions()
    }
}

// MARK: UITextFieldDelegate

extension ItemEditViewController: UITextFieldDelegate {
    enum Mode {
        case create
        case edit(item: Item)
    }

// MARK: private

    func textFieldDidChangeSelection(_ textField: UITextField) {
        saveButton.isEnabled = nameTextField.text != ""

    }
    
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        nameTextField.text = ""
        performSegue(withIdentifier: Segue.Exit, sender: nil)
    }
}

// MARK: private

private extension ItemEditViewController {
    enum Segue {
        static let Exit = "Exit"
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            nameTextField.endEditing(true)
        }
    }
    
    func setupBarButtonActions() {
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(cancelButtonTapped(_:))
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(saveButtonTapped(_:))
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        switch mode {
        case .create:
            let item: Item = Item()
            var maxId: Int { return try! Realm().objects(Item.self).sorted(byKeyPath: "id").last?.id ?? 0 }
            item.id = maxId + 1
            item.name = nameTextField.text!
            try! realm!.write {
                realm!.add(item)
            }
            break
        case .edit(item: itemArray![itemId!]):
            try! realm!.write {
                realm!.add(itemArray![itemId!], update: Realm.UpdatePolicy.all)
            }
            break
        default :
            break
        }
        performSegue(withIdentifier: Segue.Exit, sender: nil)
    }
}
