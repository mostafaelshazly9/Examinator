//
//  Register.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/21/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit
//import Firebase
//import FirebaseDatabase

class Register:UIViewController{
    var accType = ""
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var college: UITextField!
    
    @IBAction func register(_ sender: UIButton) {
        User.register(email: email.text ?? "", password: password.text ?? "", college: college.text ?? "", userType: User.UserType.init(rawValue: accType)!, successHandler: { user in
            switch self.storyboard?.instantiateViewController(withIdentifier: "\(self.accType)Landing") {
            case let adminVC as AdminLanding:
                adminVC.modalPresentationStyle = .fullScreen
                self.present(adminVC,animated: true)
                
            case let professorVC as ProfessorLanding:
                ProfessorRequest.createRequest()
                AlertManager.showAlert(title: "Request sent", message: "A request to join this college as a professor has been sent to an admin and is waiting approval", target: self)
//                professorVC.modalPresentationStyle = .fullScreen
//                self.present(professorVC,animated: true)

            case let studentVC as StudentLanding:
                studentVC.modalPresentationStyle = .fullScreen
                self.present(studentVC,animated: true)
                
            default:
                print("Class not created yet")
            }
            
        }) { error in
            AlertManager.showAlert(title: "Error", message: error.localizedDescription, target: self)
            
        }
        
        
//        let ref = Database.database().reference(withPath: "users")
//        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { [weak self] user, error in
//            //            Registration successful
//            if error == nil {
//                Auth.auth().signIn(withEmail: self!.email.text!,
//                                   password: self!.password.text!)
//                let uuid = UUID().uuidString
//                let dict = [
//                    "id": uuid,
//                    "user": self!.email.text!,
//                    "type":self!.accType,
//                    "college":self!.college.text!
//                    ] as [String : Any]
//                
//                ref.child(uuid).setValue(dict)
//                
//                switch self!.storyboard?.instantiateViewController(withIdentifier: "\(self!.accType)Landing") {
//                case let adminVC as AdminLanding:
//                    adminVC.modalPresentationStyle = .fullScreen
//                    self!.present(adminVC,animated: true)
//                    
//                case let professorVC as ProfessorLanding:
//                    professorVC.modalPresentationStyle = .fullScreen
//                    self!.present(professorVC,animated: true)
//                    
//                case let studentVC as StudentLanding:
//                    studentVC.modalPresentationStyle = .fullScreen
//                    self!.present(studentVC,animated: true)
//                    
//                default:
//                    print("Class not created yet")
//                }
//                
//                
//            }else{
//                //Registration failed
//                AlertManager.showAlert(title: "Error", message: error!.localizedDescription, target: self!)
//            }
//        }
    }
    
}
