//
//  ItemEditViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "項目追加"
        nameTextField.delegate = self
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        dismiss(animated: false)
    }
    
    @IBAction func tapSave(_ sender: Any) {
        dismiss(animated: false)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextField.text != "" {
            saveButton.isEnabled = true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if nameTextField.text != "" {
            saveButton.isEnabled = true
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.endEditing(true)
    }
}
