//
//  ItemEditViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController, ItemEditViewProtocol {
    
    // MARK: ItemEditViewProtocol

    var itemId: Int?
    var initialName: String?
    var itemName: String {
        nameTextField.text ?? ""
    }
    
    // MARK: Implementation
    
    @IBOutlet weak private var saveButton: UIBarButtonItem!
    @IBOutlet weak private var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "項目追加"
        
        nameTextField.text = initialName
        nameTextField.delegate = self
        
        saveButton.isEnabled = nameTextField.text != ""
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // cancelボタンが押された場合は、遷移の前にtextを空にする
        if let barButtonItem = sender as? UIBarButtonItem, BarButtonType(rawValue: barButtonItem.tag) == .cancel {
            nameTextField.text = ""
        }
    }
}

// MARK: UITextFieldDelegate

extension ItemEditViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        saveButton.isEnabled = nameTextField.text != ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
    }
}

// MARK: private

private extension ItemEditViewController {
    // Storyboardで設定したtagの値に対応
    enum BarButtonType: Int {
        case save = 0
        case cancel = 1
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            nameTextField.endEditing(true)
        }
    }
}
