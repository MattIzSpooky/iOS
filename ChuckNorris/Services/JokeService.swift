//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

final class JokeService {
    private let client = ApiClient()
    private let jokePersistenceManager = PersistenceManager<[JokeModel]>(persistenceKey: "joke-cache")
    private let categoriesManager = PersistenceManager<[String]>(persistenceKey: "categories-cache")

    private static let AmountOfRandomJokes = 10

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
        client.fetch(client.makeUrl("/jokes", query: createUrlQueryParams(settings: settings)))
    }

    func getCategories() -> AnyPublisher<ApiResponse<[String]>, Error> {
        client.fetch(client.makeUrl("/categories"))
    }

    func getRandomJokes(settings: Settings) -> AnyPublisher<ApiResponse<[JokeModel]>, Error> {
        client.fetch(client.makeUrl("/jokes/random/\(JokeService.AmountOfRandomJokes)", query: createUrlQueryParams(settings: settings)))
    }

    private func createUrlQueryParams(settings: Settings) -> [URLQueryItem] {
        var queryItems = [URLQueryItem(name: "exclude", value: "[\(settings.excludedCategories.joined(separator: ","))]")]

        if (settings.firstName != "") {
            queryItems.append(URLQueryItem(name: "firstName", value: settings.firstName))
        }

        if (settings.lastName != "") {
            queryItems.append(URLQueryItem(name: "lastName", value: settings.lastName))
        }

        return queryItems
    }
}
