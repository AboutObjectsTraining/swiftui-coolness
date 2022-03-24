// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import Combine

class CellStore: ObservableObject {
    @Published var cellModels: [CellModel]
    
    init(cellModels: [CellModel] = []) {
        self.cellModels = cellModels
    }
}

#if DEBUG
let testData = [
    CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: CGSize(width: 20, height: 0)),
    CellModel(text: "Groovy View Cells Rock! 🎉🍾", color: Color.orange, offset: CGSize(width: 60, height: 0)),
]
#endif
