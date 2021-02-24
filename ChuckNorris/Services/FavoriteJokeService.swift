//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

final class FavoriteJokeService {
    private static let persistKey = "favorite-jokes"

    func getFavorites() -> [JokeModel] {
        var faves = [JokeModel]()

        if let data = UserDefaults.standard.data(forKey: FavoriteJokeService.persistKey) {
            if let decoded = try? JSONDecoder().decode([JokeModel].self, from: data) {
                faves = decoded
            }
        }

        return faves
    }

    func contains(_ jokes: [JokeModel], id: Int) -> Bool {
        jokes.contains(where: { p in
            p.id == id
        })
    }

    func add(_ coins: [JokeModel], coin: JokeModel) -> [JokeModel] {
        save(coins + [coin])
    }

    func remove(_ coins: [JokeModel], coin: JokeModel) -> [JokeModel] {
        save(coins.filter({ p in
            p.id != coin.id
        }))
    }

    private func save(_ coins: [JokeModel]) -> [JokeModel] {
        if let encoded = try? JSONEncoder().encode(coins) {
            UserDefaults.standard.set(encoded, forKey: FavoriteJokeService.persistKey)
        }

        return coins
    }
}