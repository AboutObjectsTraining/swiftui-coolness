// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

@main
struct CoolnessApp: App {
    // TODO: Remove `testData` shim when model is fully fleshed out.
    @StateObject var coolViewModel = CoolViewModel(cells: testData)
    
    var body: some Scene {
        WindowGroup {
            CoolView()
                .environmentObject(coolViewModel)
        }
    }
}
