//
//  EmployeeDetailViewController.swift
//  Comp
//
//  Created by Pekka Pöyry on 06.02.17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class NewProjectTableViewController: UITableViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var bdate: UITextField!
    @IBOutlet weak var dep: UITextField!
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!
    
    var project: Project! = Project()
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
            project.fname = self.fname.text!
            project.lname = self.lname.text!
            project.dep = self.dep.text!
            project.bdate = self.bdate.text!
            project.email = self.email.text!
            project.salary = Double(self.salary.text!) ?? 0.0
            project.phone1 = self.phone1.text!
            project.phone2 = self.phone2.text!
        }
    }
    
}



