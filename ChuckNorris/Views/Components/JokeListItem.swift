//
// Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI

struct JokeListItem: View {

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
            FavoriteButton(isFavorite: false)
        }
    }
}