import XCTest
@testable import Contacts

class ContactsServiceTests: XCTestCase {
    //Arrange
    let contactsService = ContactsService(MockServiceHandler())

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldVerifyContactListRetreivedCorrectly() {
        //Act
        contactsService.getContactsList { (result: Result<Contacts, Error>) in
            //Assert
            switch result {
            case .success(let contacts):
                XCTAssertTrue(contacts.count == 4, "Count Mismatch")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }

    func testShouldVerifyContactisRetreivedCorrectly() {
        //Act
        contactsService.getContact(for: 9539) { (result: Result<Contact, Error>) in
            //Assert
            switch result {
            case .success(let contact):
                XCTAssertEqual(contact.id, 9539, "Incorrect data retreived")
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
}

class MockServiceHandler: ServiceHandlerProtocol {

    func handleRequest(url: URL, completion: @escaping Response) {
        let bundle = Bundle(for: MockServiceHandler.self)
        let contactsListUrl = URL(string: "\(baseUrl)/contacts.json")!
        let contact9539Url = URL(string: "\(baseUrl)/contacts/9539.json")!
        var fileName: String?

        switch url {
        case contactsListUrl:
            fileName = "contacts"
        case contact9539Url:
            fileName = "contact9539"
        default:
            fileName = nil
        }

        if let fileName = fileName,
            let url = bundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            completion(.success(data))
            return
        }
        completion(.failure(ApplicationError.networkError))
    }
}
