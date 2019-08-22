import UIKit

class ContactListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var viewModel: ContactListViewModel!

    var contactsService: ContactsService! {
        didSet {
            viewModel = ContactListViewModel(contactsService: contactsService)
            initializeClosures()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UINib(nibName: "ContactTableViewCell", bundle: nil),
            forCellReuseIdentifier: "contactCell"
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.fetchContactsList()
    }

    func initializeClosures() {
        viewModel.updateView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.updateStatus = { [weak self] loading in
            DispatchQueue.main.async {
                if loading {
                    self?.activityIndicator.startAnimating()
                    self?.tableView.alpha = 0
                } else {
                    self?.activityIndicator.startAnimating()
                    self?.tableView.alpha = 1
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.contactSection.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contactSection[section]
            .contacts
            .count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "contactCell"
        ) as? ContactTableViewCell else {
            return UITableViewCell()
        }

        cell.viewModel = viewModel.contactSection[indexPath.section]
                            .contacts[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard viewModel.contactSection[section].contacts.count > 0 else {
            return nil
        }

        return viewModel.contactSection[section].sectionName
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.contactSection.compactMap { $0.sectionName }
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contactDetail") as? ContactDetailViewController else { return }

        let contactId = viewModel.contactSection[indexPath.section].contacts[indexPath.row].id

        detailViewController.contactId = contactId
        detailViewController.contactsService = contactsService

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
