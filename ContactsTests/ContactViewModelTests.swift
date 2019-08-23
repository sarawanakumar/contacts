import XCTest
@testable import Contacts

class ContactViewModelTests: XCTestCase {
    let mockContact = Contact(
        id: 1,
        firstName: "Senthil",
        lastName: "Vel",
        profilePic: "/img.png",
        favorite: true,
        url: nil,
        phoneNumber: "678234654",
        email: "ks@gmail.co.in"
    )

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShouldVerifyIfContactViewModelIsPopulatedProperly() {
        let viewModel = ContactViewModel(contact: mockContact)

        XCTAssertEqual(viewModel.fullName, "Senthil Vel", "Incorrect name")
        XCTAssertEqual(viewModel.mobile, "678234654", "incorrect Phone")
        XCTAssertEqual(viewModel.email, "ks@gmail.co.in", "Incorrect email")
        XCTAssertNotNil(viewModel.favouriteImage, "Incorrect flag")
        XCTAssertEqual(viewModel.profilePicUrl, baseUrl + "/img.png", "Incorrecturl")
    }
}
