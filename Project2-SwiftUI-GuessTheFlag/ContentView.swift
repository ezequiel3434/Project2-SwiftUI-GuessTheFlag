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
    @State private var animate = false
    @State private var wrongAnswerOpacity = [0.0,0.0,0.0]
    struct FlagImage: View {
        var countryName: String
        
        var body: some View {
            Image(countryName).renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
        }
    }
    
    
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
                ForEach(0..<3) { flagSelection in
                    Button(action: {
                        // flag tapped
                        
                        if flagSelection == self.correctAnswer {
                            withAnimation(.easeOut(duration: 1)) {
                                self.animate = true
                            }
                        } else {
                            withAnimation(.easeOut(duration: 0.25)) {
                                self.wrongAnswerOpacity[flagSelection] = 1
                                
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.flagTapped(flagSelection)
                        }
                    }) {
                        FlagImage(countryName: self.countries[flagSelection])
                    }
                    .rotation3DEffect(
                        flagSelection == self.correctAnswer && self.animate ? .degrees(180) : .degrees(0),
                        axis: (x:0 , y: 1, z: 0)
                    )
                        .opacity(flagSelection != self.correctAnswer && self.animate ? 0.25 : 1)
                        .overlay(Capsule()
                            .fill(Color.red)
                         .opacity(self.wrongAnswerOpacity[flagSelection])
                    )
                    
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
        self.wrongAnswerOpacity = [0.0,0.0,0.0]
        self.animate = false
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
