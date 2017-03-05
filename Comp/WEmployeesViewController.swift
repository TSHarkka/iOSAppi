import UIKit

class WEmployeesViewController: UITableViewController {
    
    var wemployees: [WEmployee] = []
    var project: Project! = Project()
    var projIndex: IndexPath!
    var pid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("project =" , self.project , "\n")
        self.pid = self.project.id
        self.refreshControl?.addTarget(self, action: #selector(WEmployeesViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
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
        print("pid=" + pid + "\n")
        WEmployee.getWEmployees(id:pid) {(wemployees) in
            self.wemployees = wemployees
            print("wemp: ")
            print(self.wemployees)
            
            DispatchQueue.main.async(execute: {
                print("wemp: ")
                print(self.wemployees.count)
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
        return wemployees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WEmployeeCell", for: indexPath) as! WEmployeeCell
        
        let wemployee = wemployees[indexPath.row] as WEmployee
        cell.wemployee = wemployee
        
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
            
            let wemp = self.wemployees[indexPath.row]
            WEmployee.deleteWEmployee(wemp: wemp, postCompleted: { (succeeded, msg) -> () in
                print ("delete wemp " + msg)
                
                if succeeded {
                    
                    self.wemployees.remove(at: indexPath.row)
                    
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wemployeeDetail"  {
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            let nav = segue.destination as! UINavigationController
            let detailWEmployee = nav.topViewController as! WEmployeeDetailViewController
            
            detailWEmployee.wemployee = self.wemployees[indexPath!.row]
            detailWEmployee.wempIndex = indexPath
            
        }
    }
    */
    
    // if cancel is pressed in wemployee details
    @IBAction func cancelToProject (_ segue: UIStoryboardSegue) {
        
    }
    
    // if Done is pressed in wemployee details
    @IBAction func saveToWEmployees(_ segue:UIStoryboardSegue) {
        
        if let WEmployeeController = segue.source as? NewWEmployeeViewController {
            WEmployee.createWEmployee(wemp:WEmployeeController.wemployee, postCompleted: { (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
            
        }
    }
}
