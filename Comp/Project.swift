import Foundation

struct Project {
    var id: String
    var pname: String?
}

extension Project {
    init() {
        self.id = ""
        self.pname = ""
    }
}

extension Project {
    init?(json: [String: Any]) {
        self.id = (json["id"] as? String)!
        self.pname = json["pname"] as? String ?? ""
        }
}

extension Project {
    
    static func getProjects(completion: @escaping ([Project]) -> Void) {
        var projects: [Project] = []
        let getUrl = "projects"
        
        Api.read(getUrl: getUrl) { (data, succeeded, error)
            in
            
            if !succeeded {
                print(error as Any)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let projectsData = parsedData["data"] as! [[String:Any]]
                    
                    for case let result in projectsData {
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
    
    static func deleteProject(proj: Project, postCompleted : @escaping (Bool, String) -> Void) {
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
    
    static func createProject(proj: Project, postCompleted : @escaping (Bool, String) -> Void) {
        let createUrl = "project"
        Api.write(method: "POST",
                  body:["pname":proj.pname!]
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
    static func updateProject(proj: Project , postComleted : @escaping (Bool, String) -> Void) {
        let updateUrl = "project/" + proj.id
        Api.write(method:"PUT",
                  body:["pname":proj.pname!]
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
