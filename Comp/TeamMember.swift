import Foundation

struct TeamMember {
    var eid: String
    var fname: String?
    var lname: String?
    var hours: Double?
    var id: String?
    var pname: String?
    var image: String?
}

extension TeamMember {
    init() {
        self.eid = ""
        self.fname = ""
        self.lname = ""
        self.hours = 0.0
        self.id = ""
        self.pname = ""
        self.image=""
    }
}

extension TeamMember {
    init?(json: [String: Any]) {
        self.eid = (json["id"] as? String)!
        self.fname = json["fname"] as? String ?? ""
        self.lname = json["lname"] as? String ?? ""
        let tmpHours = json["hours"] as? String ?? "0.0"
        self.hours = Double(tmpHours)
        self.id = json["id"] as? String ?? ""
        self.pname = json["pname"] as? String ?? ""
        self.image = json["image"] as? String ?? ""
    }
}

extension TeamMember {
    
    static func getTeamMembers(completion: @escaping ([TeamMember]) -> Void) {
        var teamMembers: [TeamMember] = []
        let getUrl = "projectdetails/2"
        
        Api.read(getUrl: getUrl) { (data, succeeded, error)
            in
            
            if !succeeded {
                print(error as Any)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let teamMembersData = parsedData["data"] as! [[String:Any]]
                    
                    for case let result in teamMembersData {
                        if let teamMember = TeamMember(json: result) {
                            teamMembers.append(teamMember)
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            completion(teamMembers)
        }
        
    }
    
    static func deleteTeamMember(tmem: TeamMember, postCompleted : @escaping (Bool, String) -> Void) {
        let deleteUrl = "projectdetails/" + tmem.eid
        Api.write(method: "DELETE", body:[:],postUrl:deleteUrl, postCompleted:  { (succeeded: Bool, msg: String) -> () in
            
            if(succeeded) {
                print( "DELETE Success!")
            }
            else {
                print("DELETE Failed!")
            }
            postCompleted (succeeded, msg)
        })
    }
    
    static func createTeamMember(tmem: TeamMember, postCompleted : @escaping (Bool, String) -> Void) {
        let createUrl = "projectdetails"
        Api.write(method: "POST",
                  body:["fname":tmem.fname!,
                        "lname":tmem.lname!,
                        "hours":tmem.hours!,
                        "id":tmem.id!,
                        "pname":tmem.pname!,
                        "image":tmem.image!]
            ,postUrl:createUrl, postCompleted:  { (succeeded: Bool, msg: String) -> () in
                
                if(succeeded) {
                    print( "CREATE Success!")
                }
                else {
                    print("CREATE Failed!")
                }
                postCompleted (succeeded, msg)
        })
    }
    
    // Tämä asetettava sequeUnwindin identifieriksi, jotta toimenpiteet tehdaan
    static func updateTeamMember(tmem: TeamMember , postCompleted : @escaping (Bool, String) -> Void) {
        let updateUrl = "projectdetails/" + tmem.eid
        Api.write(method:"PUT",
                  body:["fname":tmem.fname!,
                        "lname":tmem.lname!,
                        "hours":tmem.hours!,
                        "id":tmem.id!,
                        "pname":tmem.pname!,
                        "image":tmem.image!]
            ,postUrl:updateUrl, postCompleted: { (succeeded: Bool, msg: String) -> () in
                
                if(succeeded) {
                    print( "UPDATE Success!")
                }
                else {
                    print("UPDATE Failed!")
                }
                postCompleted (succeeded, msg)
        })
    }
}
