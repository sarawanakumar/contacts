import Foundation

typealias Response = (Result<Data, Error>) -> Void

struct ServiceHandler {
    static let shared = ServiceHandler()
    private var session = URLSession.shared

    private init() {}

    func handleRequest(
        _ url: URL,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        session.dataTask(with: url) { (data, _, error) in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            }
            completion(.failure(ApplicationError.networkError))
        }
    }
}
