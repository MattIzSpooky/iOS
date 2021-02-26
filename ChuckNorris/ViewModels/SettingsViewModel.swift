//
// Created by Matthijs Kropholler on 26/02/2021.
//

import Foundation

final class SettingsViewModel : ObservableObject {
    private let settingsService = SettingsService()

    @Published() var settings = Settings()

    init() {
        settings = settingsService.get()
    }

    func save() -> Void {
        settingsService.save(settings: settings)
    }
}