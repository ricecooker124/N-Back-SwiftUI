//
//  SettingsSwiftUIView.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import SwiftUI

struct SettingsSwiftUIView: View {
    @EnvironmentObject var rootVM: N_Back_SwiftUIVM

    var body: some View {
        Form {
            Section(header: Text("Stimuli mode")) {
                Picker("Mode", selection: $rootVM.settings.mode) {
                    ForEach(StimulusMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                Text("Visual = rutor, Audio = bokstäver, Dual = båda samtidigt.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section(header: Text("N-back & round length")) {
                Stepper(value: $rootVM.settings.nBack, in: 1...5) {
                    Text("n-back: \(rootVM.settings.nBack)")
                }

                Stepper(value: $rootVM.settings.sequenceLength, in: 5...50, step: 1) {
                    Text("Events per round: \(rootVM.settings.sequenceLength)")
                }
            }

            Section(header: Text("Tempo")) {
                Slider(value: $rootVM.settings.stepInterval, in: 0.5...5.0, step: 0.1) {
                    Text("Time between events")
                }
                Text(String(format: "Time/event: %.1f s", rootVM.settings.stepInterval))
            }

            Section(header: Text("Visual settings")) {
                Stepper(value: $rootVM.settings.gridDimension, in: 2...5) {
                    Text("Grid size: \(rootVM.settings.gridDimension) x \(rootVM.settings.gridDimension)")
                }
            }

            Section(header: Text("Audio settings")) {
                Stepper(value: $rootVM.settings.audioLetterCount, in: 1...9) {
                    Text("Number of letters: \(rootVM.settings.audioLetterCount)")
                }
                Text("Letters used: A–J (utan I), första \(rootVM.settings.audioLetterCount) används.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Section {
                Button(role: .destructive) {
                    rootVM.settings.resetToDefaults()
                } label: {
                    Text("Reset to defaults")
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsSwiftUIView()
                .environmentObject(N_Back_SwiftUIVM())
        }
    }
}
