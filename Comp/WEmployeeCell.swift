import UIKit

class WEmployeeCell: UITableViewCell {
    @IBOutlet weak var fnameLabel: UILabel!
    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var eidLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var pnameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    // https://home.tamk.fi/~poypek/iosapi24/images/wemployees/m10.png
    
    var wemployee: WEmployee! {
        didSet {
            fnameLabel.text = wemployee.fname!
            lnameLabel.text = wemployee.lname!
            eidLabel.text = wemployee.eid
            hoursLabel.text = String(wemployee.hours!)
            pnameLabel.text = wemployee.pname!

         
            /*
            if let empImg = wemployee?.image {
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
            */
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
