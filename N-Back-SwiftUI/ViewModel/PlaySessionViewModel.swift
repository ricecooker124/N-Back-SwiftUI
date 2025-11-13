//
//  PlaySessionViewModel.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import Foundation
import AVFoundation

final class PlaySessionViewModel: ObservableObject {

    @Published private(set) var state = GameState()

    private var timer: Timer?
    private let synthesizer = AVSpeechSynthesizer()
    private var model = N_BackSwiftUIModel(count: 0)


    var sequence: [Int] { state.sequence }
    var currentIndex: Int? { state.currentIndex }
    var eventNumber: Int { state.eventNumber }
    var correctResponses: Int { state.correctResponses }
    var isRunning: Bool { state.isRunning }
    var currentLetter: String? { state.currentLetter }
    var highScore: Int { state.highScore }


    func start(using settings: SettingsViewModel) {
        guard !state.isRunning else { return }

        let combinations: Int
        switch settings.mode {
        case .visual:
            combinations = settings.gridDimension * settings.gridDimension

        case .audio:
            combinations = settings.audioLetterCount

        case .dual:
            combinations = min(
                settings.gridDimension * settings.gridDimension,
                settings.audioLetterCount
            )
        }

        state.sequence = model.generateSequence(
            length: settings.sequenceLength,
            combinations: combinations,
            matchPercentage: 20,
            nback: settings.nBack
        )

        state.eventNumber = 0
        state.correctResponses = 0
        state.currentLetter = nil
        state.isRunning = true
        state.hasMatchedCurrentEvent = false


        advance(using: settings)

        timer = Timer.scheduledTimer(withTimeInterval: settings.stepInterval,
                                     repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.advance(using: settings)
        }
    }

    func stop() {
        state.isRunning = false
        timer?.invalidate()
        timer = nil
        state.currentIndex = nil
        state.currentLetter = nil
        state.hasMatchedCurrentEvent = false

        if state.correctResponses > state.highScore {
            state.highScore = state.correctResponses
            UserDefaults.standard.set(state.highScore, forKey: "NBackHighScore")
        }
    }


    func evaluateMatch(nBack: Int) -> Bool? {

        guard state.isRunning else { return nil }

        guard !state.hasMatchedCurrentEvent else { return nil }

        let i = state.eventNumber - 1
        let j = i - nBack

        guard i >= 0, j >= 0 else {
            return nil
        }

        state.hasMatchedCurrentEvent = true

        if state.sequence[i] == state.sequence[j] {
            state.correctResponses += 1
            return true
        } else {
            return false
        }
    }


    private func advance(using settings: SettingsViewModel) {
        guard state.eventNumber < state.sequence.count else {
            stop()
            return
        }

        state.hasMatchedCurrentEvent = false

        state.currentIndex = state.sequence[state.eventNumber]
        state.eventNumber += 1

        if settings.mode == .audio || settings.mode == .dual {
            speakCurrentLetter(maxLetters: settings.audioLetterCount)
        } else {
            state.currentLetter = nil
        }
    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }

    private func speakCurrentLetter(maxLetters: Int) {
        let letters = Array("ABCDEFGHJ")

        guard let idx = state.currentIndex,
              idx > 0,
              idx <= maxLetters,
              idx <= letters.count else {
            state.currentLetter = nil
            return
        }

        let letter = String(letters[idx - 1])
        state.currentLetter = letter
        speak(text: letter)
    }
}
