import Foundation

struct WEmployee {
    var eid: String
    var fname: String?
    var lname: String?
    var hours: Double?
    var id: String?
    var pname: String?
    var image: String?
}

extension WEmployee {
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

extension WEmployee {
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

extension WEmployee {
    
    static func getWEmployees(completion: @escaping ([WEmployee]) -> Void) {
        var wemployees: [WEmployee] = []
        let getUrl = "projectdetails"
        
        Api.read(getUrl: getUrl) { (data, succeeded, error)
            in
            
            if !succeeded {
                print(error as Any)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let wemployeesData = parsedData["data"] as! [[String:Any]]
                    
                    for case let result in wemployeesData {
                        if let wemployee = WEmployee(json: result) {
                            wemployees.append(wemployee)
                        }
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            completion(wemployees)
        }
        
    }
    
    static func deleteWEmployee(wemp: WEmployee, postCompleted : @escaping (Bool, String) -> Void) {
        let deleteUrl = "projectdetails/" + wemp.eid
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
    
    static func createWEmployee(wemp: WEmployee, postCompleted : @escaping (Bool, String) -> Void) {
      print("\ncreate alkaa\n")
        print(wemp, "\n")
        let createUrl = "projectdetails"
        Api.write(method: "POST",
                  body:["fname":wemp.fname!,
                        "lname":wemp.lname!,
                        "hours":wemp.hours!,
                        "id":wemp.id!,
                        "pname":wemp.pname!,
                        "image":wemp.image!]
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
}
