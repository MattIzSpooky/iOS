//
// Created by Matthijs Kropholler on 24/02/2021.
//

import Foundation

class FavoriteJokesViewModel: ObservableObject {
    private let favoriteService = FavoriteJokeService()

    @Published var favoriteJokes = [JokeModel]()

    init() {
        favoriteJokes = favoriteService.getFavorites()
    }

    func toggleFavorite(_ joke: JokeModel) -> Void {
        contains(joke) ? remove(joke) : add(joke)
    }

    func add (_ joke: JokeModel) {
        favoriteJokes = favoriteService.add(favoriteJokes, coin: joke)
    }

    func remove(_ joke: JokeModel) {
        favoriteJokes = favoriteService.remove(favoriteJokes, coin: joke)
    }

    func contains(_ joke: JokeModel) -> Bool {
        favoriteService.contains(favoriteJokes, id: joke.id)
    }
}