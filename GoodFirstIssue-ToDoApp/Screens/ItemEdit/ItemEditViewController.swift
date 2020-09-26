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
        
        setupBarButtonActions()
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
    
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        nameTextField.text = ""
        performSegue(withIdentifier: Segue.Exit, sender: nil)
    }
}
