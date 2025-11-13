//
//  VisualBoardView.swift
//  N-Back-SwiftUI
//
//  Created by Simon Alam on 2025-11-13.
//

import SwiftUI

struct VisualBoardView: View {
    let activeCell: Int?
    let gridSize: Int

    private var cells: [Int] {
        Array(1...(gridSize * gridSize))
    }

    private var gridItems: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: gridSize)
    }

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 10) {
            ForEach(cells, id: \.self) { cell in
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(activeCell == cell ? .blue : .gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        Text("\(cell)")
                            .foregroundStyle(.primary)
                    )
                    .animation(.easeInOut(duration: 0.2), value: activeCell)
            }
        }
        .padding(.horizontal)
    }
}

struct VisualBoardView_Previews: PreviewProvider {
    static var previews: some View {
        VisualBoardView(activeCell: 5, gridSize: 3)
            .padding()
    }
}
