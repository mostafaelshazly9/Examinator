//
//  ProfessorSubjectStrategyDS.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 7/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ProfessorSubjectStrategyDS:SubjectStrategyDS{
    
    override func getItems() {
        Subject.getSubjectsForProfessor(professor: User.currentUser.email) { subjects in
            self.items = subjects
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }

}
