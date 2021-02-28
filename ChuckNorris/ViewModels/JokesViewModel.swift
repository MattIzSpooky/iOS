//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

class JokesViewModel: ObservableObject {
    private let jokeService = JokeService()
    private let settingsService = SettingsService()

    var cancellable = Set<AnyCancellable>()

    @Published() var jokes = [JokeModel]()
    @Published() var categories = [String]()
    @Published() var settings = Settings()

    init() {
        settings = settingsService.get()
        getCategories()
    }

    func getJokes() -> Void {
        jokes = jokeService.jokesFromCache()

        jokeService.getJokes(settings: settings).sink(receiveCompletion: { completion in
            print("jokes: \(completion)")
        },
                receiveValue: { response in
                    self.jokes = response.value
                    self.jokeService.writeToCache(jokes: self.jokes)
                }
        ).store(in: &cancellable)
    }

    func getCategories() -> Void {
        categories = jokeService.categoriesFromCache()

        jokeService.getCategories().sink(receiveCompletion: { completion in
            print("categories: \(completion)")
        }, receiveValue: { response in
            self.categories = response.value
            self.jokeService.writeToCache(categories: self.categories)
        }).store(in: &cancellable)
    }

    func toggleExcludedCategory(category: String) {
        defer {
            objectWillChange.send() // Force update
            settingsService.save(settings: settings)
        }

        guard !categoryIsExcluded(category: category) else {
            if let index = settings.excludedCategories.firstIndex(of: category) {
                settings.excludedCategories.remove(at: index)
            }
            return
        }

        settings.excludedCategories.append(category)
    }

    func categoryIsExcluded(category: String) -> Bool {
        settings.excludedCategories.contains(category)
    }
}
