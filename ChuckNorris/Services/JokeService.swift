//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

final class JokeService {
    private let client = ApiClient()
    private let jokePersistenceManager = PersistenceManager<[JokeModel]>(persistenceKey: "joke-cache")
    private let settingsService = SettingsService()

    func fromCache() -> [JokeModel] {
        jokePersistenceManager.fromDisk() ?? [JokeModel]()
    }

    func writeToCache(jokes: [JokeModel] = []) {
        jokePersistenceManager.toDisk(items: jokes)
    }

    func getJokes() -> AnyPublisher<ApiResponse<[JokeModel]>, Error> {
        let settings = settingsService.get()

        let queryItems = [
            URLQueryItem(name: "exclude", value: "[explicit]"),
            URLQueryItem(name: "firstName", value: settings.firstName),
            URLQueryItem(name: "lastName", value: settings.lastName)
        ];

        return client.fetch(client.createURL("/jokes", query: queryItems))
    }
}