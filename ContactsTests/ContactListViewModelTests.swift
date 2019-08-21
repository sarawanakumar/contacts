import XCTest
@testable import Contacts

class ContactListViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldVerifyIfViewModelCreatedForGivenServiceResponse() {
        //Arrange
        let service = MockContactsService()

        //Act
        service.getContactsList { (result: Result<Contacts, Error>) in
            //Assert
            switch result {
            case .success(let contacts):
                XCTAssertEqual(contacts.count, 2, "Count Mismatch")
                XCTAssertEqual(contacts[0].id, 234, "Invalid Contacts")
                XCTAssertEqual(contacts[1].id, 235, "Invalid Contacts")
            case .failure:
                XCTFail("Unable to fetch data")
            }
        }
    }
}
