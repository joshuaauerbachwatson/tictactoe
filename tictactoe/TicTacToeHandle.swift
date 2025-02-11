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

import Foundation
import unigame
import SwiftUI

class TicTacToeHandle: GameHandle {
    var tokenProvider: any TokenProvider = Auth0TokenProvider()
    
    var numPlayerRange = 1...2
    
    func reset() {
        // No-op
    }
    
    func stateChanged(_ data: [UInt8]) -> (any Error)? {
        // TODO
        return nil
    }
    
    func encodeState(duringSetup: Bool) -> [UInt8] {
        // TODO
        return []
    }
    
    var setupView: (any View)? = nil
    
    var playingView: any View = TicTacToeView()
    
    var appId = "tictactoe"
}
