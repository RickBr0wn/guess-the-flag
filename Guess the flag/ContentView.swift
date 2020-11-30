//
//  ContentView.swift
//  Guess the flag
//
//  Created by Rick Brown on 29/11/2020.
//  https://www.hackingwithswift.com/books/ios-swiftui/using-stacks-to-arrange-views
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...3)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  
  @State private var playerScore = 0
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 40) {
        VStack {
          Text("Tap the flag..")
            .font(.title3)
          Text(countries[correctAnswer])
            .font(.largeTitle)
            .fontWeight(.bold)
        } // VStack
        .foregroundColor(.white)
        
        Spacer()
        
        ForEach(0..<4) { number in
          Button(action: {
            self.flagTappped(number)
          }, label: {
            Image(self.countries[number])
              .renderingMode(.original)
              .clipShape(Capsule())
              .shadow(radius: 3)
          })
        }// ForEach
        
        
        Text("Score: \(playerScore)")
          .foregroundColor(.white)
          .font(.largeTitle)
          .fontWeight(.bold)
      } // VStack
    } // ZStack
    .alert(isPresented: $showingScore, content: {
      Alert(title: Text(scoreTitle), message: {
        if scoreTitle == "Correct" {
          return Text("Your score is \(playerScore)")
        } else {
          return Text("Your final score was \(playerScore)")
        }
      }(), dismissButton: .default(Text("Continue")) {
        self.askQuestion()
        if scoreTitle == "Wrong!!" {
          playerScore = 0
        }
      })
    })
  } // Body
  
  func flagTappped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      playerScore += 1
    } else {
      scoreTitle = "Wrong!!"
    }
    showingScore = true
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...3)
  }
} // ContentView

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
