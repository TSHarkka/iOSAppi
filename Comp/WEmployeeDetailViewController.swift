import UIKit

class WEmployeeDetailViewController: UITableViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!

    
    var wemployee: WEmployee! = WEmployee()
    var wempIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id.text = self.wemployee.id
        self.fname.text = self.wemployee.fname
        self.lname.text = self.wemployee.lname

      
      /*
        let imgName: String = Api.companyImageUrl + self.wemployee.image!
        let url = URL(string: imgName)
        let data = try? Data(contentsOf: url!)
        if data != nil {
            self.image.image = UIImage(data: data!)
        }
        else {
            self.image.image = UIImage(named: "no_image")
        }
      */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "updateToWEmployees" {
            wemployee.fname = self.fname.text!
            wemployee.lname = self.lname.text!

        }
    }
    
}



