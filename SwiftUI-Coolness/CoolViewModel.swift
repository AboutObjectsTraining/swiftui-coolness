// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import Combine

final class CoolViewModel: ObservableObject {
    @Published var cells: [CellModel]
    
    init(cells: [CellModel] = []) {
        self.cells = cells
    }
}

#if DEBUG
let testData = [
    CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: CGSize(width: 20, height: 0)),
    CellModel(text: "Cool View Cells Rock! 🎉🍾", color: Color.orange, offset: CGSize(width: 60, height: 0)),
]
#endif
