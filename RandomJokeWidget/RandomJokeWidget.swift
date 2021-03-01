//
//  RandomJokeWidget.swift
//  RandomJokeWidget
//
//  Created by Matthijs Kropholler on 01/03/2021.
//

import WidgetKit
import SwiftUI

struct RandomJokeEntry: TimelineEntry {
    let date: Date
    let joke: JokeModel
}

struct RandomJokeWidgetEntryView : View {
    var entry: RandomJokeProvider.Entry

    var body: some View {
        RandomJokeWidgetView(joke: entry.joke)
    }
}

@main
struct RandomJokeWidget: Widget {
    let kind: String = "RandomJokeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RandomJokeProvider()) { entry in
            RandomJokeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Random Chuck Norris Joke")
        .description("Displays a random Chuck Norris joke.")
    }
}

struct RandomJokeWidget_Previews: PreviewProvider {
    static var previews: some View {
        RandomJokeWidgetEntryView(entry: RandomJokeEntry(date: Date(), joke: JokeModel(id: 1, joke: "test")))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
