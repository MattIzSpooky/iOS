//
//  JokesView.swift
//  ChuckNorris
//
//  Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI

struct JokesView: View {
    @ObservedObject private var jokesViewModel = JokesViewModel()
    @State private var popover = false

    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()

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

    private func trailing() -> some View {
        NavigationLink(destination: CategoriesView()
                .environmentObject(jokesViewModel)
                .onDisappear {
                    jokesViewModel.refreshSettings()
                    jokesViewModel.getJokes()
                }) {
            Text("Excl. Categories")
        }
    }

    private func leading() -> some View {
        NavigationLink(destination: SettingsView()
                .onDisappear {
                    jokesViewModel.refreshSettings()
                    jokesViewModel.getJokes()
                }) {
            Text("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JokesView()
    }
}
