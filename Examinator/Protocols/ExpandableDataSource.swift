//
//  ExpandableDataSource.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/26/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

protocol ExpandableDataSource:UITableViewDataSource{
    var items:[Item] { get set }
    
    func getItems()
}
