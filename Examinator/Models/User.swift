//
//  User.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/25/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class User{    
    static let ref = Database.database().reference(withPath: "users")
    static let currentUser = User()
    var id = ""
    var email = ""
    var college = ""
    var type = UserType.student
    var department = "dep 1"
    
    enum UserType:String{
        case student, professor, admin
    }
    
    static func login(email:String,password:String, successHandler: @escaping (_ user:User)->Void, errorHandler: @escaping (_ error:Error)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else { errorHandler(error!) ; return}
            //Determining the user's type and which landing to show
            self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
                if dataSnapShot.exists() == false {return}
                for child in dataSnapShot.children{
                    let user = (child as! DataSnapshot).value  as! [String: String]
                    if user["user"] == email{
                        currentUser.id = user["id"]!
                        currentUser.email = user["user"]!
                        currentUser.college = user["college"]!
                        currentUser.type = UserType.init(rawValue: user["type"]!)!
                        successHandler(currentUser)
                        break
                    }
                }
            }
        }
    }
    
    static func register(email:String, password:String, college:String, userType:UserType, successHandler: @escaping (_ user:User)->Void, errorHandler: @escaping (_ error:Error)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            //            Registration successful
            if error == nil {
                let uuid = UUID().uuidString
                if userType.rawValue == "student"{
                    let dict = [
                        "id": uuid,
                        "user": email,
                        "type":userType.rawValue,
                        "college":college,
                        "department": "dep 1"
                        ] as [String : Any]
                    ref.child(uuid).setValue(dict)
                }else{
                    let dict = [
                        "id": uuid,
                        "user": email,
                        "type":userType.rawValue,
                        "college":college
                        ] as [String : Any]
                    ref.child(uuid).setValue(dict)
                }
                login(email: email, password: password, successHandler: successHandler, errorHandler: errorHandler)
                
                
                
            }else{
                //Registration failed
                errorHandler(error!)
                return
            }
        }
        
    }
    
    
    
    
}
