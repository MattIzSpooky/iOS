//
// Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI

struct FavoriteButton: View {
    var action: () -> Void
    var isFavorite: Bool

    @State private var favEnum = FavoriteEnum.laugh

    var body: some View {
        Button(action: action) {
            HStack {
                Image(favEnum.GetImage(isFavorite).rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75.0, height: 75)
                        .clipShape(Circle())
            }
        }
    }
}

enum FavoriteEnum: String {
    case laugh = "chuck-norris-laugh"
    case angry = "chuck-norris-angry"

    func GetImage(_ isFavorite: Bool) -> FavoriteEnum {
        isFavorite ? .laugh : .angry
    }
}