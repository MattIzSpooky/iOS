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
    }

    private func trailing() -> some View {
        Button(action: { popover = true }) {
            Text("Categories")
        }
                .sheet(isPresented: $popover) {
                    CategoriesSheet(isPresented: $popover, categories: jokesViewModel.categories)
                }
    }

    private func leading() -> some View {
        NavigationLink(destination: SettingsView()
                .onDisappear {
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
