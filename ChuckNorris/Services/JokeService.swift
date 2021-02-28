//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

final class JokeService {
    private let client = ApiClient()
    private let jokePersistenceManager = PersistenceManager<[JokeModel]>(persistenceKey: "joke-cache")
    private let categoriesManager = PersistenceManager<[String]>(persistenceKey: "categories-cache")

    func jokesFromCache() -> [JokeModel] {
        jokePersistenceManager.fromDisk() ?? [JokeModel]()
    }

    func categoriesFromCache() -> [String] {
        categoriesManager.fromDisk() ?? [String]()
    }

    func writeToCache(jokes: [JokeModel]) {
        jokePersistenceManager.toDisk(items: jokes)
    }

    func writeToCache(categories: [String]) {
        categoriesManager.toDisk(items: categories)
    }

    func getJokes(settings: Settings) -> AnyPublisher<ApiResponse<[JokeModel]>, Error> {
        let queryItems = [
            URLQueryItem(name: "exclude", value: "[\(settings.excludedCategories.joined(separator: ","))]"),
            URLQueryItem(name: "firstName", value: settings.firstName),
            URLQueryItem(name: "lastName", value: settings.lastName)
        ];

        return client.fetch(client.makeUrl("/jokes", query: queryItems))
    }

    func getCategories() -> AnyPublisher<ApiResponse<[String]>, Error> {
        client.fetch(client.makeUrl("/categories"))
    }
}