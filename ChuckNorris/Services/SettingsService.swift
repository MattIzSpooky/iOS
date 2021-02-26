//
// Created by Matthijs Kropholler on 26/02/2021.
//

import Foundation

final class SettingsService {
    private let settingsPersistenceManager = PersistenceManager<Settings>(persistenceKey: "joke-settings")

    func get() -> Settings {
        settingsPersistenceManager.fromDisk() ?? Settings()
    }

    func save(settings: Settings) -> Void {
        settingsPersistenceManager.toDisk(items: settings)
    }
}