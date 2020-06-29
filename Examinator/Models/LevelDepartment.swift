//
//  LevelDepartment.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/29/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class LevelDepartment: Item {
    static let ref = Database.database().reference(withPath: "levelDepartment")
    var id:String
    var level:String
    var department:String
    var college:String
    var title: String { level }
    var subtitle: String { "" }
    
    init(id:String, level:String, department:String, college:String){
        self.id = id
        self.level = level
        self.department = department
        self.college = college
        
        
    }
    
    static func createLevel(_ levelName:String){
        let uuid = UUID().uuidString
        let dict = [
            "id": uuid,
            "college": User.currentUser.college,
            "level": levelName,
            "department":"root"
            ] as [String : String]

        ref.child(uuid).setValue(dict)
    }
    
    
    static func getLevels(successHandler: @escaping (_ levels:[LevelDepartment])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var requests = [LevelDepartment]()
            for child in dataSnapShot.children{
                let request = (child as! DataSnapshot).value  as! [String: String]
                if request["college"] == User.currentUser.college && request["department"] == "root"{
                    let newRequest = LevelDepartment(id: request["id"]!,
                                                     level: request["level"]!,
                                                     department: request["department"]!,
                                                     college: request["college"]!)
                        requests.append(newRequest)
                }
            }
            successHandler(requests)
        }
    }

    
//    static func createLevelDepartment(college:String,level:String,dept:String)->LevelDepartment{
//
//    }
}
