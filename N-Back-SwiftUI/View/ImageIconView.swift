//
//  ImageIconView.swift
//  N-Back-SwiftUI
//
//  Created by Jonas Willén on 2023-10-03.
//

import SwiftUI

struct ImageIconView: View {
    let title: String

    var body: some View {
        HStack {
            Image(systemName: "eye")
                .imageScale(.large)
            Text(title)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(40)
    }
}

struct ImageIconView_Previews: PreviewProvider {
    static var previews: some View {
        ImageIconView(title: "Match")
    }
}
