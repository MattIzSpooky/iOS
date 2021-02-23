//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation
import Combine

class JokesViewModel: ObservableObject {
    private let jokeService = JokeService()

    var cancellable: AnyCancellable?

    @Published() var jokes = [JokeModel]()

    init() {
        getJokes()
    }

    private func getJokes() -> Void {
        jokes = []

        cancellable = jokeService.getJokes().sink(receiveCompletion: { completion in
            print("jokes: \(completion)")
        },
                receiveValue: { response in
                    self.jokes = response.value
                }
        )
    }
}
