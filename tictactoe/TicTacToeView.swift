//
//  TestPlayingView.swift
//  UnigameTest
//
//  Created by Josh Auerbach on 12/6/24.
//

import SwiftUI
import unigame
import AuerbachLook

struct TicTacToeCellView: View {
    // Based on
    // https://gist.github.com/berikv/44ec3a531ebff1a5c95c95532b119df4
    // Adjusted to use unigame
    @Environment(UnigameModel.self) var model
    @Environment(TicTacToeHandle.self) var handle
    
    let path: IndexPath
    
    let size: CGFloat
    
    var value: Int {
        handle.cells[path[0]][path[1]]
    }
    
    private func cellTouched() {
        if value == CellUnoccupied {
            handle.cells[path[0]][path[1]] = model.thisPlayer
            model.yield() // yield _before_ setting winner bit so other side is informed
            model.winner = handle.possibleWinner()
        } // Ignore touches on occupied cells
    }

    var body: some View {
        Button(
            action: cellTouched,
            label: { cellContent })
    }

    private var cellContent: some View {
        ZStack {
            Rectangle()
                .scaledToFill()
                .foregroundColor(Color.blue)
            
            cross
                .opacity(value == 0 ? 1 : 0)
            
            circle
                .opacity(value == 1 ? 1 : 0)
            
        }
        .frame(width: self.size, height: self.size)
        .fixedSize(horizontal: true, vertical: true)
    }

    let inset = CGFloat(10)
    let lineWidth = CGFloat(5)

    private var circle: some View {
        Circle()
            .inset(by: inset)
            .stroke(Color.white, lineWidth: lineWidth)
    }

    private var cross: some View {
        GeometryReader { geometry in
            Path { path in
                let xmin = self.inset
                let xmax = geometry.size.width - self.inset
                let ymin = self.inset
                let ymax = geometry.size.height - self.inset

                path.move(to: CGPoint(x: xmin, y: ymin))
                path.addLine(to: CGPoint(x: xmax, y: ymax))
                path.move(to: CGPoint(x: xmin, y: ymax))
                path.addLine(to: CGPoint(x: xmax, y: ymin))
            }
            .stroke(Color.white, lineWidth: self.lineWidth)
        }
    }
}

struct TicTacToeView: View {
    @Environment(UnigameModel.self) var model
    @Environment(TicTacToeHandle.self) var handle
    @State private var size: CGFloat = CGFloat.zero
    var body: some View {
        ZStack {
            GeometryReader { metrics in
                Color.clear
                    .onAppear {
                        let minDimension = min(metrics.size.height, metrics.size.width)
                        size = minDimension / 3.2
                        Logger.log("Size = \(size)")
                    }

            }
            VStack(alignment: .center, spacing: 10) {
                ForEach(0..<3) { row in
                    HStack(alignment: .center, spacing: 10) {
                        ForEach(0..<3) { column in
                            TicTacToeCellView(path: [ row, column ], size: size)
                        }
                    }
                }
            }
            .onAppear {
                // Bit of a hack: create backpointer from handle to model.
                // This should really be supplied by unigame.
                handle.model = model
            }
        }
    }
}

#Preview {
    TicTacToeView()
}
