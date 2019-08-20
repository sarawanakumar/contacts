import Foundation

struct JsonCoder {
    private let decoder = JSONDecoder()

    init(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) {
        decoder.keyDecodingStrategy = keyDecodingStrategy
    }

    func decode<T: Decodable>(
        data: Data,
        completion: (Result<T, Error>) -> Void
    ) {
        do {
            let dataObject = try decoder.decode(T.self, from: data)
            completion(.success(dataObject))
        } catch let e {
            completion(.failure(e))
        }
    }
}
