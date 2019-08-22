import UIKit

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionStackView: UIStackView!
    @IBOutlet weak var customNavBar: UINavigationBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var contactId: Int!
    var contactsService: ContactsService!
    var inEditMode = false

    private var tableData = [ContactItemViewModel]()

    private var contactViewModel: ContactViewModel! {
        didSet {
            DispatchQueue.main.async {
                if !self.inEditMode {
                    self.bindViewWithData()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !inEditMode {
            activityIndicator.startAnimating()
            detailContainerView.alpha = 0
            contactsService.getContact(for: contactId) { [weak self] (result: Result<Contact, Error>) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.detailContainerView.alpha = 1
                }
                switch result {
                case .success(let contact):
                    self?.contactViewModel = ContactViewModel(contact: contact)
                case .failure:
                    ()
                }
            }
        } else {
            bindViewWithData()
        }

        setupView()
    }

    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        guard let contactEditViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contactDetail") as? ContactDetailViewController else { return }

        contactEditViewController.contactsService = contactsService
        contactEditViewController.inEditMode = true
        contactEditViewController.contactViewModel = contactViewModel

        present(contactEditViewController, animated: true, completion: nil)
    }

    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    //Private Methods
    private func bindViewWithData() {
        profileImageView.loadImageFromCache(url: contactViewModel.profilePicUrl)
        fullNameLabel.text = contactViewModel.fullName

        updateContactItemTable()
    }

    private func setupView() {
        setGradientToTopContainer()
        setNavBarItems()
        setupProfileImageView()
        hideNameAndActionStackIfRequired()
        itemTableView.tableFooterView = UIView()
    }

    private func setGradientToTopContainer() {
        let gradient = CAGradientLayer()
        let topGradColor = UIColor.white.cgColor
        let bottomGradColor = UIColor(displayP3Red: 203.0/225.0, green: 245.0/225.0, blue: 235.0/225.0, alpha: 1).cgColor

        gradient.frame = detailContainerView.bounds
        gradient.colors = [topGradColor, bottomGradColor]

        detailContainerView.layer
            .insertSublayer(gradient, at: 0)
    }

    private func setNavBarItems() {
        let editBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped(_:)))
        let tintColor = UIColor(displayP3Red: 63.0/225.0, green: 181.0/225.0, blue: 152.0/225.0, alpha: 1)

        if !inEditMode {
            customNavBar.isHidden = true
            navigationItem.rightBarButtonItem = editBarButton
            navigationItem.rightBarButtonItem?.tintColor = tintColor
            navigationController?.navigationBar.tintColor = tintColor
        } else {
            customNavBar.isHidden = false
            customNavBar.tintColor = tintColor
        }

        let navigationBar = navigationController?.navigationBar ?? customNavBar
        navigationBar?.isTranslucent = false
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
    }

    private func hideNameAndActionStackIfRequired() {
        fullNameLabel.isHidden = inEditMode
        actionStackView.isHidden = inEditMode
        containerHeightConstraint.constant = inEditMode ? 230 : 335
    }

    private func setupProfileImageView() {
        profileImageView.layer.borderWidth = 3.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }

    private func updateContactItemTable() {
        tableData.removeAll()

        if inEditMode {
            tableData.append(ContactItemViewModel(name: "First Name", value: contactViewModel.firstName, editable: inEditMode))
            tableData.append(ContactItemViewModel(name: "Last Name", value: contactViewModel.lastName, editable: inEditMode))
        }

        tableData.append(ContactItemViewModel(name: "Mobile", value: contactViewModel.mobile ?? "", editable: inEditMode))
        tableData.append(ContactItemViewModel(name: "Email", value: contactViewModel.email ?? "", editable: inEditMode))

        itemTableView.reloadData()
    }
}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contactEntryCell") as? ContactItemTableViewCell else { return UITableViewCell() }

        cell.contactItemViewModel = tableData[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
