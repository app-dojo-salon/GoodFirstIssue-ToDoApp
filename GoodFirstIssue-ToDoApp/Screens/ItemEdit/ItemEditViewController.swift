//
//  ItemEditViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController {

    @IBOutlet weak private var saveButton: UIBarButtonItem!
    @IBOutlet weak private var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "項目追加"
        nameTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            nameTextField.endEditing(true)
        }
    }
}

extension ItemEditViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        saveButton.isEnabled = nameTextField.text != ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
    }
}
