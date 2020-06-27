//
//  RequestsStrategyDS.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class RequestsStrategyDS:NSObject,ExpandableDataSource{
    var items: [Item] = []
    var tableView:UITableView!
        
    func getItems() {
        ProfessorRequest.getRequests(forCollege: User.currentUser.college) { requests in
            self.items = requests
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
        getItems()
        self.tableView = tableView
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Expandable Cell", for: indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    
}
