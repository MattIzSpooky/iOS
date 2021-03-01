//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation

class JokeModel : Codable {
    public let id: Int
    public var joke: String
    public let categories: [String]
    
    init(id: Int, joke: String, categories: [String] = []) {
        self.id = id
        self.joke = joke
        self.categories = categories
    }
}
