//
//  LevelsStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/29/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class LevelsStrategy:ExpandableTableVC, ExpandableStrategy{
    var tableViewDelegate: ExpandableDelegate = LevelsStrategyDelegate()
    var tableViewDataSource: ExpandableDataSource = LevelsStrategyDS()
    var barButton: UIBarButtonItem? = nil
    var barButtonFunction: (() -> Void)? = nil
    
    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
        AlertManager.showAlertWithTextFields(title: "Enter Level Name", message: "", textFieldPlaceHolders: ["Level Name"], target: self) { textFields in
//            alert.textFields?.forEach { print($0.text) }

            textFields.forEach {
                guard $0.text != nil && $0.text != "" else { return }
                LevelDepartment.createLevel($0.text!)
            }
        }
    }
    
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        (self.tableViewDelegate as! LevelsStrategyDelegate).dataSource = self.tableViewDataSource as! LevelsStrategyDS
        self.tableViewDelegate.rowTapped = {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardID) as! DepartmentsStrategy
            let delegate = (self.tableViewDelegate as! LevelsStrategyDelegate)
            vc.level = delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row].title
            vc.setupView(tableViewDelegate: DepartmentsStrategyDelegate(), tableViewDataSource: DepartmentsStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "SubjectStrategy", storyboardType: SubjectStrategy.self)
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
