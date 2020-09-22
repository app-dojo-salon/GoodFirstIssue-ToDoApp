//
//  ItemListViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit
import RealmSwift

class ItemListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let libraryPath = NSHomeDirectory() + "Library"
//        let filePath = NSURL(fileURLWithPath: libraryPath + "/Test.realm")
//
//        //let realm = try! Realm(fileURL: filePath as URL)
//
//        //Realm書き込み
//        let itemData = ItemModel()
//        itemData.id = 7
//        itemData.name = "apple"
//        itemData.isCheck = false
//        itemData.isDelet = true
//
//        try! realm.write {
//            realm.add(itemData)
//        }
        
        let itemData = ItemModel()

//        itemData.id = 7
        itemData.name = "apple"
        itemData.isCheck = false
        itemData.isDelet = true


        
        let realm = try! Realm()
        try! realm.write {
            
            itemData.id += 1
            realm.add(itemData)
        }
        
        
        
        
        let itemShow = realm.objects(ItemModel.self)
        for item in itemShow{
            print(item.id)
            print(item.name)
            print(item.isCheck)
            print(item.isDelet)
            
        }
        
        
        
        
        
    }


}

