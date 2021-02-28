//
// Created by Matthijs Kropholler on 28/02/2021.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoriteViewModel: FavoriteJokesViewModel

    var body: some View {
        NavigationView {
            if favoriteViewModel.favoriteJokes.isEmpty {
                Text("You have no favorites yet.")
            } else {
                List {
                    ForEach(favoriteViewModel.favoriteJokes, id: \.id) { joke in
                        NavigationLink(destination: FavoriteDetail(joke: joke)) {
                            FavoriteItem(joke: joke)
                        }
                    }.onDelete(perform: favoriteViewModel.deleteAtOffset)
                }.navigationBarTitle(Text("Favorites"), displayMode: .inline).toolbar {
                    EditButton()
                }
            }
        }.onAppear {
            favoriteViewModel.getFavorites()
        }
    }
}