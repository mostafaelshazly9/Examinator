//
//  QuestionStrategyDS.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 7/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class QuestionStrategyDS:NSObject,ExpandableDataSource{
    var items: [Item] = []
    var tableView:UITableView!
    var subject:String!
    var chapter:String!
    
    func getItems() {
        Question.getQuestions(forSubject: subject, forChapter: chapter) { questions in
            self.items = questions
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
        let cell = UITableViewCell(style: .default, reuseIdentifier: "QuestionCell")
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }
    
    
}
