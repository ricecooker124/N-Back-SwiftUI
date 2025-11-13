//
//  IconView.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-10-03.
//

import SwiftUI

struct SoundIconView: View {
    let title: String

    var body: some View {
        HStack {
            Image(systemName: "speaker.wave.3.fill")
                .imageScale(.large)
            Text(title)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(40)
    }
}

struct SoundIconView_Previews: PreviewProvider {
    static var previews: some View {
        SoundIconView(title: "Match")
    }
}
