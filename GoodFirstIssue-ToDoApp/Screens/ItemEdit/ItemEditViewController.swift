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
    private var mode: Mode!
    
    // MARK: ItemEditViewProtocol
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

        nameTextField.text = initialName
        switch mode! {
        case .create:
            title = "項目追加"
        case .edit(id: _):
            title = "項目編集"
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
        case edit(id: Int)
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
        do {
            let realm = try Realm()
            switch mode! {
            case .create:
                let item: Item = Item()
                var maxId: Int { return realm.objects(Item.self).sorted(byKeyPath: "id").last?.id ?? 0 }
                item.id = maxId + 1
                item.name = nameTextField.text!
                try! realm.write {
                    realm.add(item)
                }
            case let .edit(id: itemId):
                guard let item = realm.object(ofType: Item.self, forPrimaryKey: itemId) else {
                    assertionFailure("id is invalid")
                    return
                }
                
                try! realm.write {
                    item.name = nameTextField.text!
                }
            }
        } catch {
            print("realm error")
        }

        performSegue(withIdentifier: Segue.Exit, sender: nil)
    }
}
