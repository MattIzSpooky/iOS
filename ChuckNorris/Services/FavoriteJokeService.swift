//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

final class FavoriteJokeService {
    private let favoriteManager = PersistenceManager<[FavoriteModel]>(persistenceKey: "favorite-jokes")
    private let settingsService = SettingsService()

    func getFavorites() -> [JokeModel] {
        guard let items = favoriteManager.fromDisk() else {
            return [JokeModel]()
        }

        let settings = settingsService.get()

        return items.map({ model -> JokeModel in
            model.joke.joke = model.joke.joke
                    .replacingOccurrences(of: model.name, with: "\(settings.firstName) \(settings.lastName)")

            return model.joke
        })
    }

    func writeToDisk(favorites: [FavoriteModel]) {
        favoriteManager.toDisk(items: favorites)
    }
}