//
//  ChuckNorrisApp.swift
//  ChuckNorris
//
//  Created by Matthijs Kropholler on 23/02/2021.
//

import SwiftUI


@main
struct ChuckNorrisApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                JokesView().tabItem {
                    Image(systemName: "person")
                    Text("Jokes")
                }
                Text("The content of the second view")
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Favorites")
                        }
                Text("The content of the 3rd view")
                        .tabItem {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
            }
        }
    }
}
