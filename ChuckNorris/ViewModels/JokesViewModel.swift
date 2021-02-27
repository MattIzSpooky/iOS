//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

class JokesViewModel: ObservableObject {
    private let jokeService = JokeService()

    var cancellable = Set<AnyCancellable>()

    @Published() var jokes = [JokeModel]()
    @Published() var categories = [String]()

    init() {
        getCategories()
    }

    func getJokes() -> Void {
        jokes = jokeService.fromCache()

        jokeService.getJokes().sink(receiveCompletion: { completion in
            print("jokes: \(completion)")
        },
                receiveValue: { response in
                    self.jokes = response.value
                    self.jokeService.writeToCache(jokes: self.jokes)
                }
        ).store(in: &cancellable)
    }

    func getCategories() ->  Void {
        jokeService.getCategories().sink(receiveCompletion: { completion in
            print("categories: \(completion)")
        }, receiveValue: { response in
            self.categories = response.value
        }).store(in: &cancellable)
    }
}
