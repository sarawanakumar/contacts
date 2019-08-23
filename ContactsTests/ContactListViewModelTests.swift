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
        let vm = ContactListViewModel(contactsService: service)

        //Act
        vm.fetchContactsList()

        //Assert
        XCTAssertEqual(vm.contactSection.count, 27, "Count Mismatch")
        XCTAssertEqual(vm.contactSection[17].sectionName, "R", "Invalid Contacts")
        XCTAssertEqual(vm.contactSection[17].contacts[0].id, 235, "Invalid Contacts")
    }
}
