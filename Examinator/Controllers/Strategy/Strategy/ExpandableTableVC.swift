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
        case subjects, chapters, questions, students, professors, levels, departments, requests, results, examSubjects, structures ,unknown
    }
    
    static func setupView(forView selectedView:ViewType)-> ExpandableTableVC{
        switch selectedView {
        case .requests:
            let strategy = RequestsStrategy()
            strategy.setupView(tableViewDelegate: RequestsStrategyDelegate(), tableViewDataSource: RequestsStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "ProfessorRequestHandler", storyboardType: ProfessorRequestHandler.self)
            return strategy
        case .levels:
            let strategy = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LevelsVC") as! LevelsStrategy
            strategy.setupView(tableViewDelegate: LevelsStrategyDelegate(), tableViewDataSource: LevelsStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "DepartmentsStrategy", storyboardType: DepartmentsStrategy.self)
            return strategy
        case .departments:
            let strategy = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DepartmentsStrategy") as! DepartmentsStrategy
            strategy.setupView(tableViewDelegate: DepartmentsStrategyDelegate(), tableViewDataSource: DepartmentsStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)
            return strategy
        case .professors:
            let strategy = ProfessorStrategy()
            strategy.setupView(tableViewDelegate: ProfessorStrategyDelegate(), tableViewDataSource: ProfessorStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)
            return strategy
        case .subjects:
            let strategy = ProfessorSubjectStrategy()
            strategy.setupView(tableViewDelegate: SubjectStrategyDelegate(), tableViewDataSource: ProfessorSubjectStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "ChapterStrategy", storyboardType: ChapterStrategy.self)
            return strategy
//        case .structures:
//            let strategy = ProfessorSubjectStrategy()
//            strategy.setupView(tableViewDelegate: SubjectStrategyDelegate(), tableViewDataSource: ProfessorSubjectStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "ChapterStrategy", storyboardType: ChapterStrategy.self)
//            
//            strategy.tableViewDelegate.rowTapped = {
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ExamStructureVC") as! ExamStructureVC
//                let delegate = (strategy.tableViewDelegate as! SubjectStrategyDelegate)
//                vc.subject = delegate.dataSource.items[strategy.tableView.indexPathForSelectedRow!.row].id
//                strategy.navigationController?.pushViewController(vc, animated: true)
//            }
            return strategy
            
            
            
        default:
            print("Class not implemented yet")
            return ExpandableTableVC()
        }
    }
    
}
