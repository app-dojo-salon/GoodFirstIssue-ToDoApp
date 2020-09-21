//
//  Mode.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Yoshiki Izumi on 2020/09/21.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import Foundation

enum Mode {
    case create
    case edit(id: Int, name: String)
}
