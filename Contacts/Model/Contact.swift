typealias Contacts = [Contact]

struct Contact: Codable {
    let id: Int
    let firstName, lastName, profilePic: String
    let favorite: Bool
    let url: String?
    let phoneNumber: String?
    let email: String?

    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

extension Contact: Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.fullName < rhs.fullName
    }
}

