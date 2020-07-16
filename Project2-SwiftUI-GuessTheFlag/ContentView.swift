//
//  ContentView.swift
//  Project2-SwiftUI-GuessTheFlag
//
//  Created by Ezequiel Parada Beltran on 11/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    @State private var showingAlert = false
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
        "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var score: Int = 0
    @State private var scoreTitle = ""
    @State private var message = ""
    
    
    
    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
        
//        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
        
//        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
//
//
//        Button(action: {
//            print("Button was tapped")
//        }) {
//            HStack(spacing: 10){
//                Image(systemName: "pencil")
//                Text("Tap me!")
//            }
//
//        }
        
        
        
        
//        Button("Show Alert"){
//            self.showingAlert = true
//        }
//        .alert(isPresented: $showingAlert){
//        Alert(title: Text("Hello SwiftUI"), message: Text("This is some detail message"), dismissButton: .default(Text("Ok")))
//        }
        
        ZStack{
                
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30){
                
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                }
                    ForEach(0..<3) { number in
                        Button(action: {
                            // flag tapped
                            
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number]).renderingMode(.original)
                            .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    
                }
                
                Text("Score: \(score)")
                .foregroundColor(.white)
                
                Spacer()
            }
            
        }
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue"), action: {
                self.ascQuestion()
            }) )
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            message = "Good one!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
            message = "That’s the flag of \(countries[number])"
            score -= 1
        }
        
        showingScore = true
    }
    
    func ascQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
