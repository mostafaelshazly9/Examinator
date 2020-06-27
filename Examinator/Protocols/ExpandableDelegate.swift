//
//  ExpandableDelegate.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/26/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

protocol ExpandableDelegate:UITableViewDelegate{
    var editFunction: ((_ item:Item)-> Void)? { get set }
    var deleteFunction: ((_ item:Item)-> Void)? { get set }
    var rowTapped:(() -> Void)? { get set }
}

extension ExpandableDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //TODO:
//    }
    
    //TODO:
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//    }
    
}
