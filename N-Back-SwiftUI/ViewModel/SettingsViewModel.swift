//
//  SettingsViewModel.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import Foundation

/// Vilken typ av stimuli spelet ska använda
enum StimulusMode: String, CaseIterable, Identifiable {
    case visual
    case audio
    case dual   // för framtiden (dual n-back)

    var id: String { rawValue }

    var title: String {
        switch self {
        case .visual: return "Visual"
        case .audio:  return "Audio"
        case .dual:   return "Dual"
        }
    }
}

/// Hanterar alla användarinställningar + lagring i UserDefaults
final class SettingsViewModel: ObservableObject {

    @Published var mode: StimulusMode { didSet { persist() } }
    @Published var nBack: Int { didSet { persist() } }
    @Published var sequenceLength: Int { didSet { persist() } }
    @Published var stepInterval: Double { didSet { persist() } }
    @Published var gridDimension: Int { didSet { persist() } }
    @Published var audioLetterCount: Int { didSet { persist() } }

    private let defaults = UserDefaults.standard

    init() {
        // Läs sparade värden eller använd defaults
        let savedMode = defaults.string(forKey: Keys.mode) ?? StimulusMode.visual.rawValue
        mode = StimulusMode(rawValue: savedMode) ?? .visual

        let savedN      = defaults.integer(forKey: Keys.nBack)
        let savedLength = defaults.integer(forKey: Keys.sequenceLength)
        let savedStep   = defaults.double(forKey: Keys.stepInterval)
        let savedGrid   = defaults.integer(forKey: Keys.gridDimension)
        let savedAudio  = defaults.integer(forKey: Keys.audioLetterCount)

        nBack          = savedN      == 0 ? 2    : savedN
        sequenceLength = savedLength == 0 ? 20   : savedLength
        stepInterval   = savedStep   == 0 ? 1.0  : savedStep
        gridDimension  = savedGrid   == 0 ? 3    : savedGrid
        audioLetterCount = savedAudio == 0 ? 6   : savedAudio
    }

    func resetToDefaults() {
        mode = .visual
        nBack = 2
        sequenceLength = 20
        stepInterval = 1.0
        gridDimension = 3
        audioLetterCount = 6
        persist()
    }

    private func persist() {
        defaults.set(mode.rawValue, forKey: Keys.mode)
        defaults.set(nBack, forKey: Keys.nBack)
        defaults.set(sequenceLength, forKey: Keys.sequenceLength)
        defaults.set(stepInterval, forKey: Keys.stepInterval)
        defaults.set(gridDimension, forKey: Keys.gridDimension)
        defaults.set(audioLetterCount, forKey: Keys.audioLetterCount)
    }

    private struct Keys {
        static let mode            = "settings.mode"
        static let nBack           = "settings.nBack"
        static let sequenceLength  = "settings.sequenceLength"
        static let stepInterval    = "settings.stepInterval"
        static let gridDimension   = "settings.gridDimension"
        static let audioLetterCount = "settings.audioLetterCount"
    }
}
