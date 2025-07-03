//
//  TicTacToeHelp.swift
//  tictactoe
//
//  Created by Josh Auerbach on 2/19/25.
//

import Foundation
import unigame
import AuerbachLook

struct TicTacToeHelp: HelpHandle {
    var appSpecificTOC: [HelpTOCEntry] = [
        HelpTOCEntry("Playing", "Playing and Winning A Tic-Tac-Toe Game")
    ]
    
    var generalDescription = "A Tic-Tac-Toe game for two possibly distant players."
    
    var appSpecificHelp: String
    
    var baseURL: URL?

    var email: String? = nil
    
    var appName: String = "Tic-Tac-Toe"
    
    var tipResetter: (any TipResetter)? = nil
    
    init() {
        guard let path = Bundle.main.url(forResource: "TicTacToeHelp", withExtension: "html") else {
            Logger.logFatalError("Help for TicTacToe could not be found")
        }
        baseURL = path
        guard let html = try? String(contentsOf: path, encoding: .utf8) else {
            Logger.logFatalError("Help for TicTacToe could not be read")
        }
        appSpecificHelp = html
    }
}
