import UIKit

class ProjectDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pnameText: UITextField!
    @IBOutlet weak var midText: UITextField!
    @IBOutlet weak var fnameText: UITextField!
    @IBOutlet weak var lnameText: UITextField!

    
    var project: Project! = Project()
    var projIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idLabel.text = self.project.id
        self.pnameText.text = self.project.pname
        self.midText.text = self.project.mid
        self.fnameText.text = self.project.fname
        self.lnameText.text = self.project.lname

        
        /*
        let imgName: String = Api.companyImageUrl + self.project.image!
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
        
        if segue.identifier == "updateToProjects" {
            project.pname = self.pnameText.text!
            project.mid = self.midText.text!
            project.fname = self.fnameText.text!
            project.lname = self.lnameText.text!
        }
    }
}
