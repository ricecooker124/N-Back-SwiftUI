//
//  GameSwiftUIView.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import SwiftUI

struct GameSwiftUIView: View {
    @EnvironmentObject var vm: N_Back_SwiftUIVM
    @State private var showErrorFlash = false

    var body: some View {
        VStack(spacing: 16) {

            VStack(spacing: 4) {
                Text("Mode: \(vm.mode.title)")
                Text("n = \(vm.n) • Events: \(vm.numberOfEvents) • \(String(format: "%.1f", vm.timeBetweenEvents))s")
                Text("Event \(min(vm.eventNumber, vm.numberOfEvents)) / \(vm.numberOfEvents)")
                Text("Correct: \(vm.correctResponses)")
            }
            .font(.headline)

            if vm.mode == .audio || vm.mode == .dual {
                AudioStimulusView(letter: vm.currentLetter)
            }

            if vm.mode == .visual || vm.mode == .dual {
                VisualBoardView(
                    activeCell: vm.currentIndex,
                    gridSize: vm.gridSize
                )
            }

            Spacer()

            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    if vm.mode == .visual {
                        Button {
                            handleMatch()
                        } label: {
                            ImageIconView(title: "Match")
                        }
                    } else if vm.mode == .audio {
                        Button {
                            handleMatch()
                        } label: {
                            SoundIconView(title: "Match")
                        }
                    } else if vm.mode == .dual {
                        Button {
                            handleMatch()
                        } label: {
                            ImageIconView(title: "Match")
                        }

                        Button {
                            handleMatch()
                        } label: {
                            SoundIconView(title: "Match")
                        }
                    }
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(showErrorFlash ? Color.red.opacity(0.6) : Color.clear)
                )
                .animation(.easeInOut(duration: 0.2), value: showErrorFlash)
                .disabled(!vm.isRunning)
                
                Button(vm.isRunning ? "Stop" : "Start") {
                    vm.isRunning ? vm.stopRound() : vm.startRound()
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Single N-Back")
    }

    private func handleMatch() {
        if let result = vm.pressMatch() {
            if !result {
                showErrorFlash = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showErrorFlash = false
                }
            }
        }
    }
}

struct GameSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        GameSwiftUIView()
            .environmentObject(N_Back_SwiftUIVM())
    }
}
