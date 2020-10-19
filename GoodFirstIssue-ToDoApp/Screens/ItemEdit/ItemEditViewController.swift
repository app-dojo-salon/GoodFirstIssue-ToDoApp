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

    // 仮のデータ型
    struct Item {
        var id: Int
        var name: String
    }
    // 仮のデータ配列（Realmから取得する予定）
    var itemArray: [Item] = []

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
        title = "項目追加"

        switch mode {
        case .create:
            nameTextField.text = initialName
            break
        case let .edit(item: item):
            if itemArray.contains(where: { $0.id == item.id }) {
                nameTextField.text = item.name
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
        performSegue(withIdentifier: Segue.Exit, sender: nil)
    }
}
