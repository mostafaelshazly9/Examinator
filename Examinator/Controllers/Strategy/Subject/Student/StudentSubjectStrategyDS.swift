//
//  StudentSubjectStrategyDS.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/6/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class StudentSubjectStrategyDS:SubjectStrategyDS{
    
    override func getItems() {
        Subject.getSubjects(forDepartment: User.currentUser.department) { subjects in
            self.items = subjects
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }

}
