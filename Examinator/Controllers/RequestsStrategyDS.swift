//
//  RequestsStrategyDS.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class RequestsStrategyDS:NSObject,ExpandableDataSource{
    var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var tableView:UITableView!
        
    func getItems() {
        ProfessorRequest.getRequests(forCollege: User.currentUser.college) { requests in
            self.items = requests
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
        getItems()
        self.tableView = tableView
        return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Expandable Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    
}
