//
//  Item.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Yoshiki Izumi on 2020/10/19.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import RealmSwift

class Item: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isChecked: Bool = false
    @objc dynamic var isDeleted: Bool = false
    
    override static func primaryKey() -> String? {
        "id"
    }
}
