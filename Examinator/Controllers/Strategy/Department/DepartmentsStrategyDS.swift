//
//  DepartmentsStrategyDS.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/29/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class DepartmentsStrategyDS:NSObject,ExpandableDataSource{
    var items: [Item] = []
    var tableView:UITableView!
    var level:String = ""

    func getItems() {
        LevelDepartment.getLevelDepartments(forLevel: level) { levelDepartment in
            self.items = levelDepartment
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            self.tableView = tableView
            getItems()
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Expandable Cell", for: indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DepartmentCell")
        cell.textLabel?.text = items[indexPath.row].subtitle
        return cell
    }
    
    
}
