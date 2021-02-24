//
// Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI

struct JokeListItem: View {
    @EnvironmentObject private var favoriteJokeViewModel: FavoriteJokesViewModel

    let joke: JokeModel

    var body: some View {
        HStack {
            VStack {
                Text(joke.joke)

                if (!joke.categories.isEmpty) {
                    Spacer()
                    Text(joke.categories.joined(separator: ", ")).foregroundColor(Color.blue)
                }
            }
            Spacer()
            FavoriteButton(action: {
                favoriteJokeViewModel.toggleFavorite(joke)
            }, isFavorite: favoriteJokeViewModel.contains(joke))
        }
    }
}