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
        NavigationView {
            if jokesViewModel.jokes.isEmpty {
                ProgressView()
            } else {
                List(jokesViewModel.jokes, id: \.id) { joke in
                    JokeListItem(joke: joke)
                }.listStyle(PlainListStyle())
                        .navigationBarTitle(Text("Jokes"), displayMode: .inline)
                        .navigationBarItems(leading: leading(), trailing: trailing())
            }
        }.onAppear {
                    jokesViewModel.getJokes()
                }
                .navigationViewStyle(StackNavigationViewStyle())
    }

    private func refresh() -> Void {
        jokesViewModel.refreshSettings()
        jokesViewModel.getJokes()
    }

    private func trailing() -> some View {
        NavigationLink(destination: CategoriesView()
                .environmentObject(jokesViewModel)
                .onDisappear(perform: refresh)) {
            Text("Excl. Categories")
        }
    }

    private func leading() -> some View {
        NavigationLink(destination: SettingsView()
                .onDisappear(perform: refresh)) {
            Text("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JokesView()
    }
}
