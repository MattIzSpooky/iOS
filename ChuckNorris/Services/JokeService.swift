//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

final class JokeService {
    private let client = ApiClient()

    private static let persistenceKey = "joke-cache"

    func fromCache() -> [JokeModel] {
        var jokes = [JokeModel]()

        if let data = UserDefaults.standard.data(forKey: JokeService.persistenceKey) {
            if let decoded = try? JSONDecoder().decode([JokeModel].self, from: data) {
                jokes = decoded
            }
        }

        return jokes
    }

    func writeToCache(jokes: [JokeModel] = []) {
        if let encoded = try? JSONEncoder().encode(jokes) {
            UserDefaults.standard.set(encoded, forKey: JokeService.persistenceKey)
        }
    }

    func getJokes() -> AnyPublisher<ApiResponse<[JokeModel]>, Error> {
        client.fetch(client.createURL("/jokes", query: [URLQueryItem(name: "exclude", value: "[explicit]")]))
    }
}