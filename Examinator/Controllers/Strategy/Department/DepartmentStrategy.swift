//
//  DepartmentStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/29/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class DepartmentsStrategy:ExpandableTableVC, ExpandableStrategy{
    var tableViewDelegate: ExpandableDelegate = DepartmentsStrategyDelegate()
    var tableViewDataSource: ExpandableDataSource = DepartmentsStrategyDS()
    var barButton: UIBarButtonItem? = nil
    var barButtonFunction: (() -> Void)? = nil
    var level:String = ""
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        AlertManager.showAlertWithTextFields(title: "Enter Department Name", message: "", textFieldPlaceHolders: ["Department Name"], target: self) { textFields in
//            alert.textFields?.forEach { print($0.text) }

            textFields.forEach {
                guard $0.text != nil && $0.text != "" else { return }
                LevelDepartment.createLevelDepartment(level: self.level, department: $0.text!)
            }
        }
    }
    
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        (self.tableViewDataSource as! DepartmentsStrategyDS).level = level
        (self.tableViewDelegate as! DepartmentsStrategyDelegate).dataSource = self.tableViewDataSource as! DepartmentsStrategyDS
        self.tableViewDelegate.rowTapped = {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardID) as! SubjectStrategy
            let delegate = (self.tableViewDelegate as! DepartmentsStrategyDelegate)
            vc.level = delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row].title
            vc.department = delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row].subtitle
            vc.setupView(tableViewDelegate: SubjectStrategyDelegate(), tableViewDataSource: SubjectStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.reloadData()
        self.barButtonFunction = barButtonFunction
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewDataSource.getItems()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.tableView.reloadData()
        }
        
    }
}
