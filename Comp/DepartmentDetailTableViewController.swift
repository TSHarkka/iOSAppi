//
//  DepartmentDetailTableViewController.swift
//  Comp
//
//  Created by Tommi Seppä on 28/02/17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class DepartmentDetailTableViewController: UITableViewController {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var dname: UITextField!
    
    // Muuttujat osastojen tallentamista ja lapikaymsita varten
    var department: Department! = Department()
    var depIndex: IndexPath!
    
    // Toimenpiteet nakyman kaynnsitamisen yhteydessa
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Haetaan
        self.id.text = self.department.id
        self.dname.text = self.department.dname
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
