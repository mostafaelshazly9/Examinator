//
//  ProfessorRequestHandler.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ProfessorRequestHandler:UIViewController{
    var request:ProfessorRequest!
    @IBOutlet weak var professorLabel: UILabel!
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        request.acceptRequest()
        dismiss(animated: true)
    }
    @IBAction func rejectButtonTapped(_ sender: UIButton) {
        request.rejectRequest()
        dismiss(animated: true)
    }
    
    func setupView(request:ProfessorRequest){
        self.request = request
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professorLabel.text = request.professor
    }
}
