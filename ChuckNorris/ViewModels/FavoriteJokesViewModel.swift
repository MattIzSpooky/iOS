//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

class FavoriteJokesViewModel: ObservableObject {
    private let favoriteService = FavoriteJokeService()

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

        favoriteService.writeToDisk(favorites: favoriteJokes)
    }

    func remove(joke: JokeModel) {
        favoriteJokes = favoriteJokes.filter({ p in
            p.id != joke.id
        })

        favoriteService.writeToDisk(favorites: favoriteJokes)
    }

    func deleteAtOffset(at offset: IndexSet) {
        favoriteJokes.remove(atOffsets: offset)

        favoriteService.writeToDisk(favorites: favoriteJokes)
    }
}