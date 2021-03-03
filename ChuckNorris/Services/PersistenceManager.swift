//
// Created by Matthijs Kropholler on 26/02/2021.
//

import Foundation

final class PersistenceManager<T: Codable> {
    private let persistenceKey: String

    init(persistenceKey: String) {
        self.persistenceKey = persistenceKey
    }

    func fromDisk() -> T? {
        var item: T? = nil

        if let data = UserDefaults.standard.data(forKey: persistenceKey) {
            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                item = decoded
            }
        }

        return item
    }

    func toDisk(items: T) {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: persistenceKey)
        }
    }
}