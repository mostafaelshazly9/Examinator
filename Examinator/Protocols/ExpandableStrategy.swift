//
//  ExpandableStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/26/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

protocol ExpandableStrategy: UITableViewController {
//    var tableViewDelegate:ExpandableDelegate { get set }
//    var tableViewDataSource: ExpandableDataSource { get set }
    var barButton:UIBarButtonItem? { get set }
    var barButtonFunction:(()->Void )?  { get set }
    
    func barButtonTapped()->Void
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type)
}


extension ExpandableStrategy{
    
    func barButtonTapped(){
        guard barButtonFunction != nil else { return }
        barButtonFunction!()
    }
    
//    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
//        self.tableViewDelegate = tableViewDelegate
//        self.tableViewDataSource = tableViewDataSource
//        self.barButtonFunction = barButtonFunction
//        //Bar button cannot be created due to protocol constraints
//        //TODO: edit and delete functions and storyboard type
//        
//    }
}
