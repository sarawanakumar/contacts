import UIKit

class ContactListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ContactListViewModel! {
        didSet {
            initializeClosures()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self?.tableView.alpha = 0
                } else {
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

extension ContactListViewController: UITableViewDataSource, UITabBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
