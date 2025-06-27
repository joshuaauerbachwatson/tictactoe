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

import SwiftUI
import unigame
import AuerbachLook

@main
struct tictactoeApp: App {
    @State private var model = UnigameModel(gameHandle: TicTacToeHandle.self)
    var body: some Scene {
        WindowGroup {
            if let handle = model.gameHandle as? TicTacToeHandle {
                unigame.ContentView()
                    .environment(model)
                    .environment(handle)
            } else {
                Logger.logFatalError("Inexplicably, the gameHandle is not a TicTacToeHandle")
            }
        }
    }
}
