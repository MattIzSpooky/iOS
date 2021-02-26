//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

class JokesViewModel: ObservableObject {
    private let jokeService = JokeService()

    var cancellable: AnyCancellable?

    @Published() var jokes = [JokeModel]()

    func getJokes() -> Void {
        jokes = jokeService.fromCache()

        cancellable = jokeService.getJokes().sink(receiveCompletion: { completion in
            print("jokes: \(completion)")
        },
                receiveValue: { response in
                    self.jokes = response.value
                    self.jokeService.writeToCache(jokes: self.jokes)
                }
        )
    }
}