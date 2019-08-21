import Foundation
import UIKit

struct ContactViewModel {
    var fullName: String
    var profilePicUrl: String
    var favouriteImage: UIImage?

    init(contact: Contact) {
        self.fullName = contact.fullName
        self.profilePicUrl = baseUrl + contact.profilePic

        if contact.favorite {
            self.favouriteImage = UIImage(imageLiteralResourceName: "home_favourite")
        }
    }
}
