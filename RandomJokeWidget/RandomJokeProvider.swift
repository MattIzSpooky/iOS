//
//  RandomJokeProvider.swift
//  RandomJokeWidgetExtension
//
//  Created by Matthijs Kropholler on 01/03/2021.
//

import Foundation
import WidgetKit

struct RandomJokeProvider: TimelineProvider {
    private let randomJokeViewModel = RandomJokeViewModel()

    private static let TimeIntervalInSeconds = 2

    func placeholder(in context: Context) -> RandomJokeEntry {
        RandomJokeEntry(date: Date(), joke: JokeModel(id: 1, joke: "test"))
    }

    func getSnapshot(in context: Context, completion: @escaping (RandomJokeEntry) -> ()) {
        let entry = RandomJokeEntry(date: Date(), joke: JokeModel(id: 1, joke: "test"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RandomJokeEntry>) -> ()) {
        randomJokeViewModel.getRandomJoke { response in
            let date = Date()
            let calendar = Calendar.current

            let entries = response?.enumerated().map { offset, currentJoke -> RandomJokeEntry in
                let newDate = calendar.date(byAdding: .second, value: offset * RandomJokeProvider.TimeIntervalInSeconds, to: date) ?? date

                return RandomJokeEntry(date: newDate, joke: currentJoke)
            }

            let timeLine = Timeline(entries: entries ?? [], policy: .atEnd)

            completion(timeLine)
        }
    }
}
