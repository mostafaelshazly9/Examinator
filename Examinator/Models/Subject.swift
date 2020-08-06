//
//  Subject.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Subject:Item{
    static let ref = Database.database().reference(withPath: "Subject")
    var id:String
    var name:String
    var level:String
    var department:String
    var college:String
    var professor:String
    var title: String { name }
    var subtitle: String { "" }

    
    init(id:String = UUID().uuidString, name:String, professor:String, level:String, department:String, college:String) {
        self.id = id
        self.name = name
        self.professor = professor
        self.level = level
        self.department = department
        self.college = college
    }
    
    static func createSubject(_ name:String, byProfessor professorName:String, level levelName:String, department departmentName:String){
        let uuid = UUID().uuidString
        let dict = [
            "id": uuid,
            "college": User.currentUser.college,
            "level": levelName,
            "department":departmentName,
            "name":name,
            "professor":professorName
            ] as [String : String]

        ref.child(uuid).setValue(dict)
    }
    
    
    static func getSubjects(forLevel levelName:String, forDepartment departmentName:String, successHandler: @escaping (_ subjects:[Subject])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var subjects = [Subject]()
            for child in dataSnapShot.children{
                let subject = (child as! DataSnapshot).value  as! [String: String]
                if subject["college"] == User.currentUser.college && subject["level"] == levelName && subject["department"] == departmentName{
                    let newSubject = Subject(id: subject["id"]!,
                                             name: subject["name"]!,
                                             professor: subject["professor"]!,
                                             level: subject["level"]!,
                                             department: subject["department"]!,
                                             college: subject["college"]!)
                        subjects.append(newSubject)
                }
            }
            successHandler(subjects)
        }
    }
    
    static func getSubjects(forDepartment departmentName:String, successHandler: @escaping (_ subjects:[Subject])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var subjects = [Subject]()
            for child in dataSnapShot.children{
                let subject = (child as! DataSnapshot).value  as! [String: String]
                if subject["college"] == User.currentUser.college && subject["department"] == departmentName{
                    let newSubject = Subject(id: subject["id"]!,
                                             name: subject["name"]!,
                                             professor: subject["professor"]!,
                                             level: subject["level"]!,
                                             department: subject["department"]!,
                                             college: subject["college"]!)
                        subjects.append(newSubject)
                }
            }
            successHandler(subjects)
        }
    }


    static func getSubjectsForProfessor(professor :String, successHandler: @escaping (_ subjects:[Subject])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var subjects = [Subject]()
            for child in dataSnapShot.children{
                let subject = (child as! DataSnapshot).value  as! [String: String]
                if subject["college"] == User.currentUser.college && subject["professor"] == professor{
                    let newSubject = Subject(id: subject["id"]!,
                                             name: subject["name"]!,
                                             professor: subject["professor"]!,
                                             level: subject["level"]!,
                                             department: subject["department"]!,
                                             college: subject["college"]!)
                        subjects.append(newSubject)
                }
            }
            successHandler(subjects)
        }
    }


}
