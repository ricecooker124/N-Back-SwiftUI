//
//  AudioStimulusView.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import SwiftUI

struct AudioStimulusView: View {
    let letter: String?

    var body: some View {
        Text(letter ?? "...")
            .font(.system(size: 64, weight: .bold, design: .rounded))
            .padding(.top, 20)
    }
}

struct AudioStimulusView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AudioStimulusView(letter: "A")
            AudioStimulusView(letter: nil)
        }
    }
}
