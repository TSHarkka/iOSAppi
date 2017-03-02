//
//  NewDepartmentTableViewController.swift
//  Comp
//
//  Created by Tommi Seppä on 28/02/17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class NewDepartmentTableViewController: UITableViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dnameText: UITextField!

    
    var department: Department! = Department()
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
        if segue.identifier == "saveToDepartment" {
            print(self.idLabel.text!)
            print(self.dnameText.text!)
            department.dname = self.dnameText.text!
        }
    }

    }