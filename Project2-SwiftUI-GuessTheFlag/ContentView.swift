//
//  ContentView.swift
//  Project2-SwiftUI-GuessTheFlag
//
//  Created by Ezequiel Parada Beltran on 11/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
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
        
        Button("Show Alert"){
            self.showingAlert = true
        }
        .alert(isPresented: $showingAlert){
        Alert(title: Text("Hello SwiftUI"), message: Text("This is some detail message"), dismissButton: .default(Text("Ok")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
