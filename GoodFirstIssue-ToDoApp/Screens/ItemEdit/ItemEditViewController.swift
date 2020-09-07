//
//  ItemEditViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit

class ItemEditViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "項目追加"
        nameTextField.delegate = self
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ItemEditViewController.tapped(_:)))
        
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        dismiss(animated: false)
    }
    
    @IBAction func tapSave(_ sender: Any) {
        dismiss(animated: false)
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

extension ItemEditViewController: UIGestureRecognizerDelegate {
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            nameTextField.endEditing(true)
        }
    }
}
