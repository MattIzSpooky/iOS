//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

class FavoriteJokesViewModel: ObservableObject {
    private let favoriteService = FavoriteJokeService()
    private let settingsService = SettingsService()

    @Published var favoriteJokes = [JokeModel]()

    func getFavorites() {
        favoriteJokes = favoriteService.getFavorites()
    }

    func toggleFavorite(_ joke: JokeModel) -> Void {
        contains(joke: joke) ? remove(joke: joke) : add(joke: joke)
    }

    func contains(joke: JokeModel) -> Bool {
        favoriteJokes.contains(where: { p in
            p.id == joke.id
        })
    }

    func add(joke: JokeModel)  {
        favoriteJokes.append(joke)

        toDisk()
    }

    func remove(joke: JokeModel) {
        favoriteJokes = favoriteJokes.filter({ p in
            p.id != joke.id
        })

        toDisk()
    }

    private func toDisk() {
        let settings = settingsService.get()

        let favorites = favoriteJokes.map { model -> FavoriteModel in
            FavoriteModel(joke: model, name: "\(settings.firstName) \(settings.lastName)")
        }

        favoriteService.writeToDisk(favorites: favorites)
    }

    func deleteAtOffset(at offset: IndexSet) {
        favoriteJokes.remove(atOffsets: offset)

        toDisk()
    }
}