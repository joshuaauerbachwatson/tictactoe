/**
 * Copyright (c) 2021-present, Joshua Auerbach
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import unigame
import SwiftUI
import AuerbachLook

let CellUnoccupied = 3

@Observable
public final class TicTacToeHandle: GameHandle {
    
    public static func makeModel() -> UnigameModel<TicTacToeHandle> {
        Logger.log("TicTacToeHandle is requested to make a UnigameModel")
        return UnigameModel(gameHandle: TicTacToeHandle())
    }
    
    // Weak pointer to the model
    public weak var model: UnigameModel<TicTacToeHandle>?
    
    public var helpHandle: any HelpHandle = TicTacToeHelp()
    
    public var initialScoring: unigame.Scoring = .Off

    // The cells of the game.
    // A 3 indicates the cell is unoccupied.
    // Otherwise (0 or 1) the cell is occupied by the player with that player index
    // By convention, the player with player index 0 always plays "x"
    var cells = [[Int]](repeating: [Int](repeating: CellUnoccupied, count: 3), count: 3)

    // Possible numbers of players (GameHandle)
    public var numPlayerRange = 1...2    // TODO figure out how this game works in solitaire mode

    // Reset for new game.  This consists in emptying the cell grid (GameHandle)
    public func reset() {
        cells = [[Int]](repeating: [Int](repeating: CellUnoccupied, count: 3), count: 3)
    }
    
    // If someone has one the game, return their player index, else return nil
    func possibleWinner() -> Int? {
        // Find possible row winners
        for row in 0...2 {
            if let ans = possibleWinner(cells[row]) {
                return ans
            }
        }
        // Find possible column winners
        for col in 0...2 {
            let vals = cells.map { $0[col] }
            if let ans = possibleWinner(vals) {
                return ans
            }
        }
        // Find possible diagonal winners
        var diag = [ cells[0][0], cells[1][1], cells[2][2]]
        if let ans = possibleWinner(diag) {
            return ans
        }
        diag = [ cells[0][2], cells[1][1], cells[2][0] ]
        return possibleWinner(diag)
    }
    
    // Working subroutine of possibleWinner(): evaluates a single row, column, or diagonal
    private func possibleWinner(_ vals: [Int]) -> Int? {
        var winner: Int? = nil
        for val in vals {
            if val == CellUnoccupied {
                return nil
            }
            if winner != nil && val != winner {
                return nil
            }
            winner = val
        }
        return winner
    }
    
    // Receive a new game state consisting of cells contents (GameHandle)
    public func stateChanged(_ data: [UInt8]) -> (any Error)? {
        Logger.log("stateChanged: data=\(data)")
        // Update cells all at once to avoid artifacts
        var cells = self.cells
        var dataIndex = 0
        for rowIndex in 0...2 {
            for cellIndex in 0...2 {
                cells[rowIndex][cellIndex] = Int(data[dataIndex])
                dataIndex += 1
            }
        }
        Logger.log("stateChanged: resulting cells=\(cells)")
        self.cells = cells
        model?.winner = possibleWinner()
        return nil
    }
    
    // Encode the current game state consiting of cells contents (GameHandle)
    public func encodeState(duringSetup: Bool) -> [UInt8] {
        var data = [UInt8]()
        Logger.log("encodeState: cells=\(cells)")
        for rowIndex in 0...2 {
            for cellIndex in 0...2 {
                data.append(UInt8(cells[rowIndex][cellIndex]))
            }
        }
        Logger.log("encodedState: resulting data=\(data)")
        return data
    }
    
    // This game has no setup view (GameHandle)
    public var setupView: (any View)? = nil
    
    // The playing view (GameHandle)
    public var playingView: any View = TicTacToeView()
    
    // The app id (must correspond to Bonjour declaration in info.plist) (GameHandle)
    public var appId = "tictactoe"
}
