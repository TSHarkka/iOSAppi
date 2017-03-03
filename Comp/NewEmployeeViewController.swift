import UIKit

class NewEmployeeViewController: UITableViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var bdate: UITextField!
    @IBOutlet weak var dep: UITextField!
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!
    
    var employee: Employee! = Employee()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        if segue.identifier == "saveToEmployees" {
            employee.fname = self.fname.text!
            employee.lname = self.lname.text!
            employee.dep = self.dep.text!
            employee.bdate = self.bdate.text!
            employee.email = self.email.text!
            employee.salary = Double(self.salary.text!) ?? 0.0
            employee.phone1 = self.phone1.text!
            employee.phone2 = self.phone2.text!
        }
    }
    
}



