//
//  ItemListViewController.swift
//  GoodFirstIssue-ToDoApp
//
//  Created by Turara on 2020/09/06.
//  Copyright © 2020 GoodFirstIssue. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(ItemCell.loadNib(), forCellReuseIdentifier: ItemCell.reuseIdentifier)
        }
    }
    
    var itemList: [(String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ItemListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier, for: indexPath) as? ItemCell else { return UITableViewCell() }
        cell.configure(name: itemList[indexPath.row], checked: false)
        return cell
    }
    
}

extension ItemListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


