//
//  EmployeeDetailViewController.swift
//  Comp
//
//  Created by Pekka Pöyry on 06.02.17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class ProjectDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var bdate: UITextField!
    @IBOutlet weak var dname: UITextField!
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone1: UITextField!
    @IBOutlet weak var phone2: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var project: Project! = Project()
    var empIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id.text = self.project.id
        self.fname.text = self.project.fname
        self.lname.text = self.project.lname
        self.bdate.text = self.project.bdate
        self.dname.text = self.project.dname
        self.email.text = self.project.email
        self.salary.text = String(format: "%.2f", self.project.salary!)
        self.phone1.text = self.project.phone1
        self.phone2.text = self.project.phone2
        
        let imgName: String = Api.companyImageUrl + self.project.image!
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
            project.fname = self.fname.text!
            project.lname = self.lname.text!
            project.dname = self.dname.text!
            project.bdate = self.bdate.text!
            project.email = self.email.text!
            project.salary = Double(self.salary.text!) ?? 0.0
            project.phone1 = self.phone1.text!
            project.phone2 = self.phone2.text!
        }
    }
    
}



