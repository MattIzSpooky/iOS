//
//  RandomJokeViewModel.swift
//  RandomJokeWidgetExtension
//
//  Created by Matthijs Kropholler on 01/03/2021.
//

import Foundation
import Combine

final class RandomJokeViewModel : ObservableObject {
    private let jokeService = JokeService()
    private let settingsService = SettingsService()
    
    var cancellable: AnyCancellable?
    
    func getRandomJoke(completion: @escaping ([JokeModel]?) -> Void) {
        let settings = settingsService.get()
        
        cancellable = jokeService.getRandomJokes(settings: settings).sink(receiveCompletion: { completion in
            print("random: \(completion)")
        },
                receiveValue: { response in
                    completion(response.value)
                }
        )
    }
}
