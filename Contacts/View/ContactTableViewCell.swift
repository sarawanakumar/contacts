import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    var viewModel: ContactViewModel? {
        didSet {
            bindData()
        }
    }

    func bindData() {
        nameLabel.text = viewModel?.fullName
        favouriteImageView.image = viewModel?.favouriteImage

        if let url = viewModel?.profilePicUrl {
            profileImageView.loadImageFromCache(url: url)
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

    override func prepareForReuse() {
        profileImageView.image = nil
        favouriteImageView.image = nil
        nameLabel.text = ""
    }
}
