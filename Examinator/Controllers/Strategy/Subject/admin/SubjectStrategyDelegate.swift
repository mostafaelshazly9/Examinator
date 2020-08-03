//
//  SubjectStrategyDelegate.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/30/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class SubjectStrategyDelegate:NSObject, ExpandableDelegate{
    var editFunction: ((_ item:Item)-> Void)? = nil
    var deleteFunction: ((_ item:Item)-> Void)? = nil
    var rowTapped:(() -> Void)? = nil
    var dataSource:SubjectStrategyDS!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard rowTapped != nil else { return }
        rowTapped!()
    }
}
