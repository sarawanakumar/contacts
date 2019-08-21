import Foundation

struct ContactViewModel {
    var fullName: String

    init(contact: Contact) {
        self.fullName = contact.fullName
    }
}
