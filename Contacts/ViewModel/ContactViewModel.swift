import Foundation
import UIKit

struct ContactViewModel {
    var fullName: String
    var profilePicUrl: String
    var favouriteImage: UIImage?
    var id: Int

    init(contact: Contact) {
        self.fullName = contact.fullName
        self.profilePicUrl = baseUrl + contact.profilePic
        self.id = contact.id

        if contact.favorite {
            self.favouriteImage = UIImage(imageLiteralResourceName: "home_favourite")
        }
    }
}
