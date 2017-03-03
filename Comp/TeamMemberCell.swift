import UIKit

class TeamMemberCell: UITableViewCell {
    @IBOutlet weak var fnameText: UILabel!
    @IBOutlet weak var lnameText: UILabel!
    @IBOutlet weak var hoursText: UILabel!
    @IBOutlet weak var idText: UILabel!
    @IBOutlet weak var pnameText: UILabel!

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    
    var teamMember: TeamMember! {
        didSet {
            fnameText.text = teamMember.fname!
            lnameText.text = teamMember.lname!
            hoursText.text = String(format: "%.2f", self.teamMember.hours!)
            idText.text = teamMember.id!
            pnameText.text = teamMember.pname!

            
            if let tmemImg = teamMember?.image {
                let imageUrl = URL(string: Api.companyImageUrl + tmemImg)
                
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
