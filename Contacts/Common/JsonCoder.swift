import Foundation

struct JsonCoder {
    private let decoder = JSONDecoder()

    init(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) {
        decoder.keyDecodingStrategy = keyDecodingStrategy
    }

    func decode<T>(
        data: Data,
        completion: (Result<T, Error>) -> Void
    ) where T: Decodable {
        do {
            let dataObject = try decoder.decode(T.self, from: data)
            completion(.success(dataObject))
        } catch let e {
            completion(.failure(e))
        }
    }
}
