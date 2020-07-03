//
//  ProffessorRequest.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct ProfessorRequest:Item{
    static let ref = Database.database().reference(withPath: "professorRequests")
    let id:String!
    let college:String!
    let professor:String!
    let state:String!
    var title: String { professor }
    var subtitle: String { professor }
    
    init(id:String, college:String, professor:String, state:String) {
        self.id = id
        self.college = college
        self.professor = professor
        self.state = state
    }
    
    static func createRequest(){
        let uuid = UUID().uuidString
        let dict = [
            "id": uuid,
            "college": User.currentUser.college,
            "professor": (Auth.auth().currentUser?.email)!,
            "state":"pending"
            ] as [String : String]

        ref.child(uuid).setValue(dict)

    }
    
    static func getRequest(forProfessor professor:String, successHandler: @escaping (_ request:ProfessorRequest)->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            for child in dataSnapShot.children{
                let request = (child as! DataSnapshot).value  as! [String: String]
                if request["professor"] == professor{
                    let newRequest = ProfessorRequest(id: request["id"]!,
                                                      college: request["college"]!,
                                                      professor: request["professor"]!,
                                                      state: request["state"]!)
                    successHandler(newRequest)
                    break
                }
            }
        }
    }

    static func getRequests(forCollege college:String, successHandler: @escaping (_ requests:[ProfessorRequest])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var requests = [ProfessorRequest]()
            for child in dataSnapShot.children{
                let request = (child as! DataSnapshot).value  as! [String: String]
                if request["college"] == college && request["state"] == "pending"{
                    let newRequest = ProfessorRequest(id: request["id"]!,
                                                      college: request["college"]!,
                                                      professor: request["professor"]!,
                                                      state: request["state"]!)
                    requests.append(newRequest)
                }
            }
            successHandler(requests)
        }
    }
    
    static func getAcceptedProfessorRequests(successHandler: @escaping (_ requests:[ProfessorRequest])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var requests = [ProfessorRequest]()
            for child in dataSnapShot.children{
                let request = (child as! DataSnapshot).value  as! [String: String]
                if request["college"] == User.currentUser.college && request["state"] == "accepted"{
                    let newRequest = ProfessorRequest(id: request["id"]!,
                                                      college: request["college"]!,
                                                      professor: request["professor"]!,
                                                      state: request["state"]!)
                    requests.append(newRequest)
                }
            }
            successHandler(requests)
        }
    }


    func acceptRequest(){
        ProfessorRequest.ref.child(self.id).updateChildValues(["state": "accepted"])
    }
    
    func rejectRequest(){
        ProfessorRequest.ref.child(self.id).updateChildValues(["state": "rejected"])
    }

}
