struct Contact: Codable {
    let id: Int
    let firstName, lastName, profilePic: String
    let favorite: Bool
    let url: String?
    let phoneNumber: String?
    let email: String?
}

typealias Contacts = [Contact]
