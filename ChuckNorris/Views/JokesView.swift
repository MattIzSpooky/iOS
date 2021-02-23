//
//  JokesView.swift
//  ChuckNorris
//
//  Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI

struct JokesView: View {
    @ObservedObject private var jokesViewModel = JokesViewModel()

    var body: some View {
        if jokesViewModel.jokes.isEmpty {
            ProgressView()
        } else {
            List(jokesViewModel.jokes, id: \.id) { joke in
                JokeListItem(joke: joke)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JokesView()
    }
}
