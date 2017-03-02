import UIKit

class EmployeesViewController: UITableViewController {
    
    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(EmployeesViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
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
        Employee.getEmployees { (employees) in
            self.employees = employees
            print("emp: ")
            print(self.employees)
            
            DispatchQueue.main.async(execute: {
                print("emp: ")
                print(self.employees.count)
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
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        
        let employee = employees[indexPath.row] as Employee
        cell.employee = employee
        
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
            
            let emp = self.employees[indexPath.row]
            Employee.deleteEmployee(emp: emp, postCompleted: { (succeeded, msg) -> () in
                print ("delete emp " + msg)
                
                if succeeded {
                    
                    self.employees.remove(at: indexPath.row)
                    
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
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "employeeDetail"  {
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            let nav = segue.destination as! UINavigationController
            let detailEmployee = nav.topViewController as! EmployeeDetailViewController
            
            detailEmployee.employee = self.employees[indexPath!.row]
            detailEmployee.empIndex = indexPath
            
        }
    }
    
    // if cancel is pressed in employee details
    @IBAction func cancelToEmployees (_ segue: UIStoryboardSegue) {
        
    }
    
    // if Done is pressed in employee details
    @IBAction func saveToEmployees(_ segue:UIStoryboardSegue) {
        
        if let employeeController = segue.source as? NewEmployeeViewController {
            Employee.createEmployee(emp:employeeController.employee, postCompleted: { (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
            
        }
    }
    
    @IBAction func updateToEmployees(_ segue: UIStoryboardSegue) {
        if let employeeController = segue.source as? EmployeeDetailViewController {
            Employee.updateEmployee(emp: employeeController.employee, postComleted: {
                (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
        }
    }

    
    
    
}
