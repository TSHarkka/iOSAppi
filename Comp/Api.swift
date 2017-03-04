import Foundation

struct Api {
    static var companyUrl = "https://home.tamk.fi/~poypek/iosapi27/index.php/"
    static var companyImageUrl = "https://home.tamk.fi/~poypek/iosapi27/"
    
    // this handles api reads
    static func read(getUrl: String, getCompleted:@escaping (Data?, Bool, String) -> Void) {
        let apiUrl = URL(string: self.companyUrl + getUrl)
        URLSession.shared.dataTask(with: apiUrl!) { (data, response, error)  in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    getCompleted(nil, false, String(httpResponse.statusCode))
                } else {
                    getCompleted(data, true, String(httpResponse.statusCode))
                }
            }
            
            }.resume()
    }
    
    // this handles api create, post, siikli and delete
    static func write(method: String, body : [String:Any], postUrl : String, postCompleted : @escaping (Bool, String) -> ()) {
        print ("\n" ,body, "\n")
        var request = URLRequest(url: URL(string: self.companyUrl + postUrl)!)
        
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            
        }
        catch {
            print(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    postCompleted(false, String(httpResponse.statusCode))
                } else {
                    postCompleted(true, String(httpResponse.statusCode))
                }
            }
            }.resume()
    }
    
    // this resets the db
    static func resetDb (completion: @escaping (String) -> Void){
        let url = URL(string: self.companyUrl + "resetDB")
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            completion((response?.description)!)
            print ((response?.description)!)
            }.resume()
        
    }
}
