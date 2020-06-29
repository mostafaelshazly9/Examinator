//
//  ExpandableTableVC.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ExpandableTableVC: UITableViewController{
//    var strategy = ViewType.unknown
    
    enum ViewType {
        case subjects, chapters, questions, students, professors, levels, departments, requests, results, examSubjects, unknown
    }
    
    static func setupView(forView selectedView:ViewType)-> ExpandableTableVC{
        switch selectedView {
        case .requests:
            let strategy = RequestsStrategy()
            strategy.setupView(tableViewDelegate: RequestsStrategyDelegate(), tableViewDataSource: RequestsStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "ProfessorRequestHandler", storyboardType: ProfessorRequestHandler.self)
            return strategy
        case .levels:
            let strategy = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LevelsVC") as! LevelsStrategy
            strategy.setupView(tableViewDelegate: LevelsStrategyDelegate(), tableViewDataSource: LevelsStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)
            return strategy
        default:
            print("Class not implemented yet")
            return ExpandableTableVC()
        }
    }
    
}