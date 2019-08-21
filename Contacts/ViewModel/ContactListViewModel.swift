import Foundation
import UIKit

class ContactListViewModel {
    private let contactsService: ContactsService

    var updateView: (() -> Void)?
    var updateStatus: ((Bool) -> Void)?

    var contactSection = [ContactSection]() {
        didSet {
            updateView?()
        }
    }

    private var isLoading: Bool = false {
        didSet {
            updateStatus?(isLoading)
        }
    }

    init(contactsService: ContactsService) {
        self.contactsService = contactsService
    }

    func fetchContactsList() {
        isLoading = true

        contactsService.getContactsList { [weak self] (result: Result<Contacts, Error>) in
            self?.isLoading = false
            switch result {
            case .success(let contacts):
                self?.process(contacts: contacts)
            case .failure(_):
                ()
            }
        }
    }

    private func process(contacts: Contacts) {
        var contactsArray = [ContactSection]()
        let sortedContacts = contacts.sorted(by: <)
            .map { ContactViewModel(contact: $0) }

        UILocalizedIndexedCollation.current()
            .sectionTitles
            .forEach { sectionTitle in
                let contactsForSection = sortedContacts.filter({
                    $0.fullName.hasPrefix(sectionTitle)
                })
                let contactSectionItem = ContactSection(
                    sectionName: sectionTitle.uppercased(),
                    contacts: contactsForSection
                )
                contactsArray.append(contactSectionItem)
            }
        self.contactSection = contactsArray
    }
}
