import UIKit

class TeamMemberDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var bdate: UITextField!
    @IBOutlet weak var dname: UITextField!
    @IBOutlet weak var hoursText: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var teamMember: TeamMember! = TeamMember()
    var tmemIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id.text = self.teamMember.eid
        self.fname.text = self.teamMember.fname
        self.lname.text = self.teamMember.lname
        self.hoursText.text = String(format: "%.2f", self.teamMember.hours!)
        self.dname.text = self.teamMember.id
        self.email.text = self.teamMember.pname

        
        let imgName: String = Api.companyImageUrl + self.teamMember.image!
        let url = URL(string: imgName)
        let data = try? Data(contentsOf: url!)
        if data != nil {
            self.image.image = UIImage(data: data!)
        }
        else {
            self.image.image = UIImage(named: "no_image")
        }

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
        if segue.identifier == "updateToEmployees" {
            teamMember.fname = self.fname.text!
            teamMember.lname = self.lname.text!
            teamMember.hours = Double(self.hoursText.text!) ?? 0.0
            teamMember.id = self.bdate.text!
            teamMember.pname = self.email.text!

        }
    }
    
}



