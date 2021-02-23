//
// Created by Matthijs Kropholler on 23/02/2021.
//

import Foundation

struct ApiResponse<T: Codable> : Codable {
    let type: String
    let value: T
}