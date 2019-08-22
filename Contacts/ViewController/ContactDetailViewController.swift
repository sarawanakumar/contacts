import UIKit

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var detailContainerView: UIView!

    var contactId: Int!
    var contactsService: ContactsService!

    var contactViewModel: ContactViewModel! {
        didSet {
            DispatchQueue.main.async {
                self.bindViewWithData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        contactsService.getContact(for: contactId) { [weak self] (result: Result<Contact, Error>) in
            switch result {
            case .success(let contact):
                self?.contactViewModel = ContactViewModel(contact: contact)
            case .failure:
                ()
            }
        }

        setupView()
    }

    @objc func editButtonTapped(_ sender: UIBarButtonItem) {

    }

    //Private Methods
    private func bindViewWithData() {
        profileImageView.loadImageFromCache(url: contactViewModel.profilePicUrl)
        fullNameLabel.text = contactViewModel.fullName
    }

    private func setupView() {
        setGradientToTopContainer()
        setRightBarButtonItem()
        setupProfileImageView()
    }

    private func setGradientToTopContainer() {
        let gradient = CAGradientLayer()
        let topGradColor = UIColor.white.cgColor//203, 245, 235
        let bottomGradColor = UIColor(displayP3Red: 203.0/225.0, green: 245.0/225.0, blue: 235.0/225.0, alpha: 1).cgColor

        gradient.frame = detailContainerView.bounds
        gradient.colors = [topGradColor, bottomGradColor]

        detailContainerView.layer
            .insertSublayer(gradient, at: 0)
    }

    private func setRightBarButtonItem() {
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped(_:)))
        let tintColor = UIColor(displayP3Red: 63.0/225.0, green: 181.0/225.0, blue: 152.0/225.0, alpha: 1)

        navigationItem.rightBarButtonItem = editBarButton
        navigationItem.rightBarButtonItem?.tintColor = tintColor
        navigationController?.navigationBar.tintColor = tintColor
    }

    private func setupProfileImageView() {
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }
}
