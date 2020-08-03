//
//  Chapter.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Chapter:Item{
    static let ref = Database.database().reference(withPath: "Chapter")
    var id:String
    var name:String
    var number:Int
    var subject:String
    var title: String { name }
    var subtitle: String { String(number) }

    
    init(id:String = UUID().uuidString, name:String, number:Int, subject:String) {
        self.id = id
        self.name = name
        self.number = number
        self.subject = subject
    }
    
    static func createChapter(_ name:String, number:Int, subject:String){
        let uuid = UUID().uuidString
        let dict = [
            "id": uuid,
            "subject": subject,
            "name":name,
            "number":number
            ] as [String : Any]

        ref.child(uuid).setValue(dict)
    }

    
    static func getChapters(forSubject subject:String, successHandler: @escaping (_ chapters:[Chapter])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            var chapters = [Chapter]()
            if dataSnapShot.exists() == false {return}
            for child in dataSnapShot.children{
                let chapter = (child as! DataSnapshot).value  as! [String: Any]
                if chapter["subject"] as! String == subject{
                    let newChapter = Chapter(id: chapter["id"] as! String,
                                             name: chapter["name"] as! String,
                                             number: chapter["number"] as! Int,
                                             subject: chapter["subject"] as! String)
                    chapters.append(newChapter)
                }
                    successHandler(chapters)
                    
                
            }
        }
    }

}
