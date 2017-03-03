import UIKit

class TeamMemberTableViewController: UITableViewController {
    
    var teamMembers: [TeamMember] = []
    
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
        TeamMember.getTeamMembers { (teamMembers) in
            self.teamMembers = teamMembers
            print("tmem: ")
            print(self.teamMembers)
            
            DispatchQueue.main.async(execute: {
                print("tmem: ")
                print(self.teamMembers.count)
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
        return teamMembers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberDetailTableViewCell", for: indexPath) as! TeamMemberCell
        
        let teamMember = teamMembers[indexPath.row] as TeamMember
        cell.teamMember = teamMember
        
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
            
            let tmem = self.teamMembers[indexPath.row]
            TeamMember.deleteTeamMember(tmem: tmem, postCompleted: { (succeeded, msg) -> () in
                print ("delete tmem " + msg)
                
                if succeeded {
                    
                    self.teamMembers.remove(at: indexPath.row)
                    
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
        if segue.identifier == "TeamMemberDetail"  {
            
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            let nav = segue.destination as! UINavigationController
            let detailTeamMember = nav.topViewController as! TeamMemberDetailTableViewController
            
            detailTeamMember.teamMember = self.teamMembers[indexPath!.row]
            detailTeamMember.tmemIndex = indexPath
            
        }
    }
    
    // if cancel is pressed in teamMember details
    @IBAction func cancelToTeamMembers (_ segue: UIStoryboardSegue) {
        
    }
    
    // if Done is pressed in teamMember details
    @IBAction func saveToTeamMembers(_ segue:UIStoryboardSegue) {
        
        if let teamMemberController = segue.source as? NewTeamMemberTableViewController {
            TeamMember.createTeamMember(tmem:teamMemberController.teamMember, postCompleted: { (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
            
        }
    }
    
    @IBAction func updateToTeamMembers(_ segue: UIStoryboardSegue) {
        if let teamMemberController = segue.source as? TeamMemberDetailTableViewController {
            TeamMember.updateTeamMember(tmem: teamMemberController.teamMember, postComleted: {
                (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
        }
    }

    
    
    
}
