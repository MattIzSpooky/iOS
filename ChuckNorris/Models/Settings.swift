//
// Created by Matthijs Kropholler on 26/02/2021.
//

import Foundation

class Settings: Codable {
    var firstName: String
    var lastName: String

    var excludedCategories = [String]()

    init() {
        firstName = "Chuck"
        lastName = "Norris"
    }
}
