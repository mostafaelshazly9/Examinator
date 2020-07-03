//
//  ProfessorStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 7/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ProfessorStrategy:ExpandableTableVC, ExpandableStrategy{
    var tableViewDelegate: ExpandableDelegate = ProfessorStrategyDelegate()
    var tableViewDataSource: ExpandableDataSource = ProfessorStrategyDS()
    var barButton: UIBarButtonItem? = nil
    var barButtonFunction: (() -> Void)? = nil
    
//    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
//        AlertManager.showAlertWithTextFields(title: "Enter Subject Info", message: "", textFieldPlaceHolders: ["Subject Name", "Subject Professor"], target: self) { textFields in
//
//                guard textFields[0].text != nil && textFields[0].text != "" && textFields[1].text != nil && textFields[1].text != "" else { return }
//            Subject.createSubject(textFields[0].text!, byProfessor: textFields[1].text!, level: self.level, department: self.department)
//        }
//    }
    
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        (self.tableViewDelegate as! ProfessorStrategyDelegate).dataSource = self.tableViewDataSource as! ProfessorStrategyDS
        self.tableViewDelegate.rowTapped = {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardID) as! ProfessorRequestHandler
//            let delegate = (self.tableViewDelegate as! RequestsStrategyDelegate)
//            vc.setupView(request: delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row] as! ProfessorRequest)
//            self.present(vc, animated: true)
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
