//
// Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI

struct FavoriteButton: View {
    @State var isFavorite: Bool

    var body: some View {
        Button(action: {
            isFavorite = !isFavorite
        }) {
            HStack {
                Image(isFavorite ? "chuck-norris-laugh" : "chuck-norris-angry")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75.0, height:75)
                        .clipShape(Circle())
            }
        }
    }
}