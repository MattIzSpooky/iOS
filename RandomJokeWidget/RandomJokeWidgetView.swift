//
//  RandomJokeWidgetView.swift
//  RandomJokeWidgetExtension
//
//  Created by Matthijs Kropholler on 01/03/2021.
//


import SwiftUI

struct RandomJokeWidgetView: View {

  let joke: JokeModel
    
  @Environment(\.widgetFamily) var family
    
  var body: some View {
    switch family {
       case .systemSmall:
           Text(joke.joke)
               .minimumScaleFactor(0.3)
               .padding(.all, 5)
       default:
           VStack{
               Text("Random chuck norris joke")
                   .font(.system(.headline, design: .rounded))
                   .padding()
                   
               Text(joke.joke)
                   .minimumScaleFactor(0.3)
                   .padding(.all, 5)
                   
           }.foregroundColor(.white)
           .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
           .background(Color.pink)
    }
  }
}
