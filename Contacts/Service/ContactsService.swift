//
//  ContactsService.swift
//  Contacts
//
//  Created by Saravanakumar Selladurai on 20/08/19.
//  Copyright © 2019 Saravanakumar Selladurai. All rights reserved.
//

import Foundation

let baseUrl = "https://gojek-contacts-app.herokuapp.com"

struct ContactsService {
    let serviceHandler: ServiceHandler
    let jsonCoder = JsonCoder()

    init(_ serviceHandler: ServiceHandler) {
       self.serviceHandler = serviceHandler
    }

    func getContactsList<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseUrl + "/contacts.json") else {
            return
        }

        makeRequest(url: url, completion: completion)
    }

    func getContact<T: Decodable>(for id: Int, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseUrl + "/contacts/\(id).json") else {
            completion(.failure(ApplicationError.invalidUrlError))
            return
        }

        makeRequest(url: url, completion: completion)
    }

    private func makeRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        serviceHandler.handleRequest(url) { (response) in
            switch response {
            case .success(let data):
                self.parseData(data: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func parseData<T: Decodable>(data: Data, completion: (Result<T, Error>) -> Void) {
        jsonCoder.decode(data: data) { (result: Result<T, Error>) in
            switch result {
            case .success(let dataObject):
                completion(.success(dataObject))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
