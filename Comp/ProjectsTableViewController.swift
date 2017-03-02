//
//  EmployeesViewController.swift
//  Comp
//
//  Created by Pekka Pöyry on 23.01.17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class ProjectsTableViewController: UITableViewController {
    
    var projects: [Project] = []
    
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
        Project.getEmployees { (projects) in
            self.projects = projects
            print("proj: ")
            print(self.projects)
            
            DispatchQueue.main.async(execute: {
                print("proj: ")
                print(self.projects.count)
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
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        
        let project = projects[indexPath.row] as Project
        cell.project = project
        
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
            
            let proj = self.projects[indexPath.row]
            Project.deleteEmployee(proj: proj, postCompleted: { (succeeded, msg) -> () in
                print ("delete proj " + msg)
                
                if succeeded {
                    
                    self.projects.remove(at: indexPath.row)
                    
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
            
            detailEmployee.project = self.projects[indexPath!.row]
            detailEmployee.empIndex = indexPath
            
        }
    }
    
    // if cancel is pressed in project details
    @IBAction func cancelToEmployees (_ segue: UIStoryboardSegue) {
        
    }
    
    // if Done is pressed in project details
    @IBAction func saveToEmployees(_ segue:UIStoryboardSegue) {
        
        if let employeeController = segue.source as? NewEmployeeViewController {
            Project.createEmployee(proj:employeeController.project, postCompleted: { (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
            
        }
    }
    
    @IBAction func updateToEmployees(_ segue: UIStoryboardSegue) {
        if let employeeController = segue.source as? EmployeeDetailViewController {
            Project.updateEmployee(proj: employeeController.project, postComleted: {
                (succeeded, msg) -> () in
                if succeeded {
                    self.loadData()
                }
            })
        }
    }

    
    
    
}