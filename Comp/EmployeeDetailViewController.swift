//
//  EmployeeDetailViewController.swift
//  Comp
//
//  Created by Pekka Pöyry on 06.02.17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UITableViewController {
    
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
    
    var employee: Employee! = Employee()
    var empIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id.text = self.employee.id
        self.fname.text = self.employee.fname
        self.lname.text = self.employee.lname
        self.bdate.text = self.employee.bdate
        self.dname.text = self.employee.dname
        self.email.text = self.employee.email
        self.salary.text = String(format: "%.2f", self.employee.salary!)
        self.phone1.text = self.employee.phone1
        self.phone2.text = self.employee.phone2
        
        let imgName: String = Api.companyImageUrl + self.employee.image!
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
            employee.fname = self.fname.text!
            employee.lname = self.lname.text!
            employee.dname = self.dname.text!
            employee.bdate = self.bdate.text!
            employee.email = self.email.text!
            employee.salary = Double(self.salary.text!) ?? 0.0
            employee.phone1 = self.phone1.text!
            employee.phone2 = self.phone2.text!
        }
    }
    
}



