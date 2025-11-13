//
//  ContentView.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-09-19.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var theViewModel: N_Back_SwiftUIVM
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Image(systemName: "brain.head.profile")
                    .imageScale(.large)
                    .font(.system(size: 40))
                    .foregroundColor(.accentColor)
                
                Text("N-Back Trainer")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("High-Score: \(theViewModel.highScore)")
                    .font(.title3)
                
                VStack(spacing: 4) {
                    Text("Current settings:")
                        .font(.headline)
                    Text("Mode: \(theViewModel.mode.title)")
                    Text("n = \(theViewModel.n)")
                    Text("Events: \(theViewModel.numberOfEvents)")
                    Text(String(format: "Time/Event: %.1f s", theViewModel.timeBetweenEvents))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Spacer()
                
                NavigationLink("Start Game") {
                    GameSwiftUIView()
                }
                .buttonStyle(.borderedProminent)
                .font(.title3)
                
                NavigationLink("Settings") {
                    SettingsSwiftUIView()
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(N_Back_SwiftUIVM())
    }
}



