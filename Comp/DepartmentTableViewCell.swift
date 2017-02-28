//
//  DepartmentTableViewCell.swift
//  Comp
//
//  Created by Tommi Seppä on 13/02/17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: UITableViewCell {
    @IBOutlet weak var depName: UILabel!

    
    var department: Department! {
        didSet {
            depName.text = department.dname!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
