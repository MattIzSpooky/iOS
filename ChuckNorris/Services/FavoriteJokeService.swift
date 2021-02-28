//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

final class FavoriteJokeService {
    private let favoriteManager = PersistenceManager<[JokeModel]>(persistenceKey: "favorite-jokes")

    func getFavorites() -> [JokeModel] {
        favoriteManager.fromDisk()  ?? [JokeModel]()
    }

    func writeToDisk(favorites: [JokeModel]) {
        favoriteManager.toDisk(items: favorites)
    }
}