//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

final class JokeService {
    private let client = ApiClient()
    private let jokePersistenceManager = PersistenceManager<[JokeModel]>(persistenceKey: "joke-cache")

    func fromCache() -> [JokeModel] {
        jokePersistenceManager.fromDisk() ?? [JokeModel]()
    }

    func writeToCache(jokes: [JokeModel] = []) {
        jokePersistenceManager.toDisk(items: jokes)
    }

    func getJokes() -> AnyPublisher<ApiResponse<[JokeModel]>, Error> {
        client.fetch(client.createURL("/jokes", query: [URLQueryItem(name: "exclude", value: "[explicit]")]))
    }
}