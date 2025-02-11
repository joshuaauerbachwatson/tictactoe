//
//  tictactoeApp.swift
//  tictactoe
//
//  Created by Josh Auerbach on 2/10/25.
//

import SwiftUI
import unigame

@main
struct tictactoeApp: App {
    @State private var model = UnigameModel(gameHandle: TicTacToeHandle())
    var body: some Scene {
        WindowGroup {
            unigame.ContentView()
                .environment(model)
        }
    }
}
