//  Project.swift
//  Company
//
//  Created by Pekka Pöyry on 02.01.17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import Foundation

struct Project {
    var id: String
    var fname: String?
    var lname: String?
    var salary: Double?
    var bdate: String?
    var email: String?
    var dep: String?
    var dname: String?
    var phone1: String?
    var phone2: String?
    var image: String?
}

extension Project {
    init() {
        self.id = ""
        self.fname = ""
        self.lname = ""
        self.salary = 0.0
        self.bdate = ""
        self.email = ""
        self.dep = ""
        self.dname=""
        self.phone1=""
        self.phone2=""
        self.image=""
    }
}

extension Project {
    init?(json: [String: Any]) {
        self.id = (json["id"] as? String)!
        self.fname = json["fname"] as? String ?? ""
        self.lname = json["lname"] as? String ?? ""
        let tmpSalary = json["salary"] as? String ?? "0.0"
        self.salary = Double(tmpSalary)
        self.bdate = json["bdate"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.dep = json["dep"] as? String ?? ""
        self.dname = json["dname"] as? String ?? ""
        self.phone1 = json["phone1"] as? String ?? ""
        self.phone2 = json["phone2"] as? String ?? ""
        self.image = json["image"] as? String ?? ""
    }
}

extension Project {
    
    static func getEmployees(completion: @escaping ([Project]) -> Void) {
        var projects: [Project] = []
        let getUrl = "projects"
        
        Api.read(getUrl: getUrl) { (data, succeeded, error)
            in
            
            if !succeeded {
                print(error as Any)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let employeesData = parsedData["data"] as! [[String:Any]]
                    
                    for case let result in employeesData {
                        if let project = Project(json: result) {
                            projects.append(project)
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            completion(projects)
        }
        
    }
    
    static func deleteEmployee(proj: Project, postCompleted : @escaping (Bool, String) -> Void) {
        let deleteUrl = "project/" + proj.id
        Api.write(method: "DELETE", body:[:],postUrl:deleteUrl, postCompleted:  { (succeeded: Bool, msg: String) -> () in
            
            if(succeeded) {
                print( "Success!")
            }
            else {
                print("Failed!")
            }
            postCompleted (succeeded, msg)
        })
    }
    
    static func createEmployee(proj: Project, postCompleted : @escaping (Bool, String) -> Void) {
        let createUrl = "project"
        Api.write(method: "POST",
                  body:["fname":proj.fname!,
                        "lname":proj.lname!,
                        "salary":proj.salary!,
                        "bdate":proj.bdate!,
                        "email":proj.email!,
                        "dep":proj.dep!,
                        "phone1":proj.phone1!,
                        "phone2":proj.phone2!,
                        "image":proj.image!]
            ,postUrl:createUrl, postCompleted:  { (succeeded: Bool, msg: String) -> () in
                
                if(succeeded) {
                    print( "Success!")
                }
                else {
                    print(" Create Failed!")
                }
                postCompleted (succeeded, msg)
        })
    }
    
    // Tämä asetettava sequeUnwindin identifieriksi, jotta toimenpiteet tehdaan
    static func updateEmployee(proj: Project , postComleted : @escaping (Bool, String) -> Void) {
        let updateUrl = "project/" + proj.id
        Api.write(method:"PUT",
                  body:["fname":proj.fname!,
                        "lname":proj.lname!,
                        "salary":proj.salary!,
                        "bdate":proj.bdate!,
                        "email":proj.email!,
                        "dep":proj.dep!,
                        "phone1":proj.phone1!,
                        "phone2":proj.phone2!,
                        "image":proj.image!]
            ,postUrl:updateUrl, postCompleted: { (succeeded: Bool, msg: String) -> () in
                
                if(succeeded) {
                    print( "Success!")
                }
                else {
                    print("Update Failed!")
                }
                postComleted (succeeded, msg)
        })
    }
}
