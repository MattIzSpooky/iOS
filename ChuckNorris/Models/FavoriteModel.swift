//
// Created by Matthijs Kropholler on 01/03/2021.
//

import Foundation

struct FavoriteModel: Codable {
    let joke: JokeModel
    let firstName: String
    let lastName: String
}