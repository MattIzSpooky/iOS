//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

final class FavoriteJokeService {
    private let favoriteManager = PersistenceManager<[FavoriteModel]>(persistenceKey: "favorite-jokes")

    private static let FallbackFirstName = "Chuck"
    private static let FallbackLastName = "Norris"

    func getFavorites(settings: Settings) -> [JokeModel] {
        guard let items = favoriteManager.fromDisk() else {
            return [JokeModel]()
        }

        guard !items.isEmpty else {
            return [JokeModel]()
        }

        return items.map({ model -> JokeModel in
            mapFavoriteToJoke(model, settings: settings)
        })
    }

    private func mapFavoriteToJoke(_ favorite: FavoriteModel, settings: Settings) -> JokeModel {
        let firstName = settings.firstName.isEmpty ? FavoriteJokeService.FallbackFirstName : settings.firstName
        let lastName = settings.lastName.isEmpty ? FavoriteJokeService.FallbackLastName : settings.lastName

        let jokeWithReplacedFirstname = favorite.joke.joke
                .replacingOccurrences(of: favorite.firstName, with: firstName)

        favorite.joke.joke = jokeWithReplacedFirstname.replacingOccurrences(of: favorite.lastName, with: lastName)

        return favorite.joke
    }

    func writeToDisk(favorites: [JokeModel], settings: Settings) {
        let firstName = settings.firstName.isEmpty ? FavoriteJokeService.FallbackFirstName : settings.firstName
        let lastName = settings.lastName.isEmpty ? FavoriteJokeService.FallbackLastName : settings.lastName

        favoriteManager.toDisk(items: favorites.map { model -> FavoriteModel in
            FavoriteModel(joke: model, firstName: firstName, lastName: lastName)
        })
    }
}