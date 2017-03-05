import UIKit

class NewProjectTableViewController: UITableViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pnameText: UITextField!
    @IBOutlet weak var midText: UITextField!
    @IBOutlet weak var fnameText: UITextField!
    @IBOutlet weak var lnameText: UITextField!

    var project: Project! = Project()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n ", project, "\n")
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
        if segue.identifier == "saveToProjects" {
            project.pname = self.pnameText.text!
            project.mid = self.midText.text!
            print("\nprepare: ", project, "\n")
        }
    }
    
}



