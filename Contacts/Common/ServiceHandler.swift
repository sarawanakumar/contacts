import Foundation

typealias Response = (Result<Data, Error>) -> Void

protocol ServiceHandlerProtocol {
    func handleRequest(url: URL, completion: @escaping Response)
}

struct ServiceHandler: ServiceHandlerProtocol {
    static let shared = ServiceHandler()
    private var session = URLSession.shared

    private init() {}

    func handleRequest(
        url: URL,
        completion: @escaping Response
    ) {
        session.dataTask(with: url) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(ApplicationError.networkError))
            }
        }.resume()
    }
}
