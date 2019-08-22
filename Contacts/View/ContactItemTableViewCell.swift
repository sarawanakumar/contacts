import UIKit

class ContactItemTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!

    var contactItemViewModel: ContactItemViewModel! {
        didSet {
            bindView()
        }
    }

    private func bindView() {
        nameLabel.text = contactItemViewModel.name
        valueTextField.text = contactItemViewModel.value
        valueTextField.isEnabled = contactItemViewModel.editable
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        valueTextField.text = nil
    }
}
