import UIKit

class DepartmentsTableViewController: UITableViewController {

    var departments: [Department] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(DepartmentsTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.loadData()
    }
    
    func handleRefresh(_ sender:AnyObject)
    {
        loadData()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() -> Void {
        Department.getDepartments { (departments) in
            self.departments = departments
            print("dep: ")
            print(self.departments)
            
            DispatchQueue.main.async(execute: {
                print("dep: ")
                print(self.departments.count)
                self.tableView.reloadData()
                
            })
            
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return departments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepartmentTableViewCell", for: indexPath) as! DepartmentTableViewCell
        
        let department = departments[indexPath.row] as Department
        cell.department = department
        
        return cell;
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let dep = self.departments[indexPath.row]
            Department.deleteDepartment(dep: dep, postCompleted: { (succeeded, msg) -> () in
                print ("delete dep " + msg)
                
                if succeeded {
                    
                    self.departments.remove(at: indexPath.row)
                    
                }
                // update ui
                DispatchQueue.main.async(execute: {
                    if (succeeded) {
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                })
            })
            
        }
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // if Done is pressed in employee details
    @IBAction func saveToDepartments(_ segue:UIStoryboardSegue) {
        
        if let departmentController = segue.source as? NewDepartmentTableViewController {
            Department.createDepartment(dep:departmentController.department, postCompleted: { (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "departmentDetail"  {
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            let nav = segue.destination as! UINavigationController
            let detailDepartment = nav.topViewController as! DepartmentDetailTableViewController
            
            detailDepartment.department = self.departments[indexPath!.row]
            detailDepartment.depIndex = indexPath
            
        }
    }
    
    // if cancel is pressed in employee details
    @IBAction func cancelToDepartments (_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func updateToDepartments(_ segue: UIStoryboardSegue) {
        if let departmentController = segue.source as? DepartmentDetailTableViewController {
            // kutsutaan department olion funktiota 
            Department.updateDepartment(dep: departmentController.department, postCompleted: {
                (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
        }
    }
 

}
