//
//  ChapterStrategyDelegate.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 7/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ChapterStrategyDelegate:NSObject, ExpandableDelegate{
    var editFunction: ((_ item:Item)-> Void)? = nil
    var deleteFunction: ((_ item:Item)-> Void)? = nil
    var rowTapped:(() -> Void)? = nil
    var dataSource:ChapterStrategyDS!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard rowTapped != nil else { return }
        rowTapped!()
    }
}
