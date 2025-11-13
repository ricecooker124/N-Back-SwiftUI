//
//  N_Back_SwiftUIVM.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-09-19.
//

import Foundation
import Combine

final class N_Back_SwiftUIVM: ObservableObject {

    @Published var settings: SettingsViewModel
    @Published var game: PlaySessionViewModel

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.settings = SettingsViewModel()
        self.game = PlaySessionViewModel()

        settings.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        game.objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }


    var highScore: Int {
        game.highScore
    }

    var mode: StimulusMode {
        get { settings.mode }
        set { settings.mode = newValue }
    }

    var n: Int {
        get { settings.nBack }
        set { settings.nBack = newValue }
    }

    var numberOfEvents: Int {
        get { settings.sequenceLength }
        set { settings.sequenceLength = newValue }
    }

    var timeBetweenEvents: Double {
        get { settings.stepInterval }
        set { settings.stepInterval = newValue }
    }

    var gridSize: Int {
        get { settings.gridDimension }
        set { settings.gridDimension = newValue }
    }

    var numberOfLetters: Int {
        get { settings.audioLetterCount }
        set { settings.audioLetterCount = newValue }
    }


    var sequence: [Int] {
        game.sequence
    }

    var currentIndex: Int? {
        game.currentIndex
    }

    var eventNumber: Int {
        game.eventNumber
    }

    var correctResponses: Int {
        game.correctResponses
    }

    var isRunning: Bool {
        game.isRunning
    }

    var currentLetter: String? {
        game.currentLetter
    }

    // MARK: - Metoder som Views redan använder

    func soundClick() {
        settings.mode = .audio
    }

    func imageClick() {
        settings.mode = .visual
    }

    func startRound() {
        game.start(using: settings)
    }

    func stopRound() {
        game.stop()
    }

    func pressMatch() -> Bool? {
        game.evaluateMatch(nBack: settings.nBack)
    }
}






