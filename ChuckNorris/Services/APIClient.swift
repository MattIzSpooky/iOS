//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

final class ApiClient {
    func fetch<T: Decodable>(_ url: URL, method: String = "GET") -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = method

        return URLSession.shared.dataTaskPublisher(for: request)
                .map { response in
                    response.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }

    func createURL(_ path: String, query: [URLQueryItem] = []) -> URL {
        var components = URLComponents()

        components.scheme = "https"
        components.host = "api.icndb.com"
        components.path = path
        components.queryItems = query

        components.queryItems?.append(URLQueryItem(name: "escape", value: "javascript"))

        return components.url!
    }
}