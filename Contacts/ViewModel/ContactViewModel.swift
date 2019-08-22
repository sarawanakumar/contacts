import Foundation
import UIKit

struct ContactViewModel {
    var fullName: String
    var profilePicUrl: String
    var favouriteImage: UIImage?
    var mobile: String?
    var email: String?
    var id: Int

    init(contact: Contact) {
        self.fullName = contact.fullName
        self.profilePicUrl = baseUrl + contact.profilePic
        self.id = contact.id
        self.mobile = contact.phoneNumber
        self.email = contact.email

        if contact.favorite {
            self.favouriteImage = UIImage(imageLiteralResourceName: "home_favourite")
        }
    }
}
