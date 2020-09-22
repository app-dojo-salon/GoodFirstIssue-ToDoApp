//
//  ItemEditViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit
import RealmSwift

class ItemEditViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "項目追加"
        nameTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(tapped(_:)))
        
        self.view.addGestureRecognizer(tapGesture)
        
        //Realm BDからの読み込み
//        let libraryPath = NSHomeDirectory() + "/Library"
//        let filePath = NSURL(fileURLWithPath: libraryPath + "/Tesr.realm")
//
//        let realm = try! Realm(fileURL: filePath as URL)
//
//        let objs = realm.objects(ItemModel.self)
//
//        var id: Int
//        var name: String
//        var isCheck: Bool
//        var isDelet: Bool
//
//        if let obj = objs.last{
//            id = obj.id
//            name = obj.name
//            isCheck = obj.isCheck
//            isDelet = obj.isDelet
//
//            print(id)
//            print(name)
//            print(isCheck)
//            print(isDelet)
        
        
        let realm = try! Realm()
        
        let itemShow = realm.objects(ItemModel.self)
        for item in itemShow{
            print(item.id)
            print(item.name)
            print(item.isCheck)
            print(item.isDelet)
            
        }
        

        
        
        
    }

    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            nameTextField.endEditing(true)
        }
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
