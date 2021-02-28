//
// Created by Matthijs Kropholler on 28/02/2021.
//

import SwiftUI
import MobileCoreServices

struct FavoriteDetail: View {
    let joke: JokeModel
    @State var showsAlert = false

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(joke.joke)

            if (!joke.categories.isEmpty) {
                Text(joke.categories.joined(separator: ", ")).foregroundColor(Color.blue)
            }

            Spacer()

            Button(action: {
                UIPasteboard.general.setValue(joke.joke, forPasteboardType: kUTTypePlainText as String)
                self.showsAlert.toggle()
            }) {
                Text("Copy to clipboard").bold()
            }.alert(isPresented: self.$showsAlert) {
                Alert(title: Text("Joke has been copied"))
            }
        }.padding()
    }
}