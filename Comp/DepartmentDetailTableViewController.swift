import UIKit

class DepartmentDetailTableViewController: UITableViewController {
    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var dnameText: UITextField!

    
    // Muuttujat osastojen tallentamista ja lapikaymsita varten
    var department: Department! = Department()
    var depIndex: IndexPath!
    
    // Toimenpiteet nakyman kaynnsitamisen yhteydessa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Haetaan
        self.idText.text = self.department.id
        self.dnameText.text = self.department.dname
        
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
        if segue.identifier == "updateToDepartments" {
            department.id = self.idText.text!
            department.dname = self.dnameText.text!
            
        }
    }
    

}
