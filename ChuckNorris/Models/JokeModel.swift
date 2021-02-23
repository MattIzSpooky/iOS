//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation

struct JokeModel : Codable {
    let id: Int
    let joke: String
    let categories: [String]
}