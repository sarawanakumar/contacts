import Foundation
import UIKit

struct AlertError {
    let controller: UIAlertController
    private var cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

    init(message: String, retry: @escaping () -> Void) {
        controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in retry() })
        controller.addAction(cancelAction)
        controller.addAction(okAction)
    }
}
