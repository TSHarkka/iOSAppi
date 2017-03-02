//
//  EmployeeCell.swift
//  Comp
//
//  Created by Pekka Pöyry on 23.01.17.
//  Copyright © 2017 Pekka Pöyry. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell {
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    // https://home.tamk.fi/~poypek/iosapi24/images/projects/m10.png
    
    var project: Project! {
        didSet {
            fname.text = project.fname!
            lname.text = project.lname!
            
            if let empImg = project?.image {
                let imageUrl = URL(string: Api.companyImageUrl + empImg)
                
                if let image = imageUrl!.cachedImage {
                    // Cached: set immediately.
                    avatarImageView.image = image
                    avatarImageView.alpha = 1
                    placeholderImageView.alpha = 0
                } else {
                    // Not cached, so load then fade it in.
                    avatarImageView.alpha = 0
                    placeholderImageView.alpha = 1
                    imageUrl!.fetchImage { image in
                        self.avatarImageView.image = image
                        UIView.animate(withDuration: 0.3, animations: {
                            self.avatarImageView.alpha = 1
                            self.placeholderImageView.alpha = 0
                        })
                    }
                }
            } else {
                // no image
                self.avatarImageView.alpha = 0
                self.placeholderImageView.alpha = 1
            }
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
