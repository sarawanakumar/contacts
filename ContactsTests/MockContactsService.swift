import Foundation
@testable import Contacts

struct MockContactsService: ContactsServiceProtocol {
    let contact1 = Contact(
        id: 234,
        firstName: "kumar",
        lastName: "ramki",
        profilePic: "/noimage",
        favorite: true,
        url: "/image",
        phoneNumber: "976547323",
        email: nil
    )

    let contact2 = Contact(
        id: 235,
        firstName: "RajKiran",
        lastName: "Sandy",
        profilePic: "/noimage",
        favorite: true,
        url: "/image",
        phoneNumber: "976547326",
        email: nil
    )

    func getContactsList<T>(completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(Result.success([contact1, contact2] as! T))
    }

    func getContact<T>(for id: Int, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(Result.success(contact2 as! T))
    }
}
