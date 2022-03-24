// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import Combine

class CellStore: ObservableObject {
    @Published var cells: [Cell]
    
    init(cells: [Cell] = []) {
        self.cells = cells
    }
}

#if DEBUG
let testData = [
    Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: CGSize(width: 20, height: 0)),
    Cell(text: "Groovy View Cells Rock! 🎉🍾", color: Color.orange, offset: CGSize(width: 60, height: 0)),
]
#endif
