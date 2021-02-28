//
// Created by Matthijs Kropholler on 28/02/2021.
//

import SwiftUI

struct FavoriteItem: View {
    let joke: JokeModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(joke.joke)

                if (!joke.categories.isEmpty) {
                    Spacer()
                    Text(joke.categories.joined(separator: ", ")).foregroundColor(Color.blue)
                }
            }
        }
    }
}