//
//  Department.swift
//  Comp
//
//  Created by Tommi Seppä on 13/02/17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import Foundation

struct Department {
    var id: String
    var dname: String?
}

extension Department {
    init() {
        self.id = ""
        self.dname=""
    }
}

extension Department {
    init?(json: [String: Any]) {
        self.id = (json["id"] as? String)!
        self.dname = json["dname"] as? String ?? ""
    }
}

extension Department {
    
    static func getDepartments(completion: @escaping ([Department]) -> Void) {
        var departments: [Department] = []
        let getUrl = "departments"
        
        Api.read(getUrl: getUrl) { (data, succeeded, error)
            in
            
            if !succeeded {
                print(error as Any)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let departmentData = parsedData["data"] as! [[String:Any]]
                    
                    for case let result in departmentData {
                        if let department = Department(json: result) {
                            departments.append(department)
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            completion(departments)
        }
        
    }
    
    static func deleteDepartment(dep: Department, postCompleted : @escaping (Bool, String) -> Void) {
        let deleteUrl = "department/" + dep.id
        Api.write(method: "DELETE", body:[:],postUrl:deleteUrl, postCompleted:  { (succeeded: Bool, msg: String) -> () in
            
            if(succeeded) {
                print( "Dep Delete Success!")
            }
            else {
                print("Dep Delete Failed!")
            }
            postCompleted (succeeded, msg)
        })
    }
    
    static func createDepartment(dep: Department, postCompleted : @escaping (Bool, String) -> Void) {
        let createUrl = "department"
        
        // lahetetaan vain nimi, db hoitaa id:n
        Api.write(method: "POST",
                  body:["dname":dep.dname!]
            ,postUrl:createUrl, postCompleted:  { (succeeded: Bool, msg: String) -> () in
                
                if(succeeded) {
                    print( "Dep Add Success!")
                }
                else {
                    print(" Dep Add Failed!")
                }
                postCompleted (succeeded, msg)
        })
    }
    
    // Tämä asetettava aina sequeUnwindin identifieriksi
    static func updateDepartment(dep: Department , postComleted : @escaping (Bool, String) -> Void) {
        let updateUrl = "department/" + dep.id
        Api.write(method:"PUT",
                  body:["dname":dep.dname!]
            ,postUrl:updateUrl, postCompleted: { (succeeded: Bool, msg: String) -> () in
                
                if(succeeded) {
                    print( "Dep Update Success!")
                }
                else {
                    print("Dep Update Failed!")
                }
                postComleted (succeeded, msg)
        })
    }
}
