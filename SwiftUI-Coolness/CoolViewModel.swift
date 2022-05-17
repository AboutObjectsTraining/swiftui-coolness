// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import Combine

final class CoolViewModel: ObservableObject {
    @Published private(set) var cells: [CellModel]
    
    init(cells: [CellModel] = []) {
        self.cells = cells
    }
}

// MARK: - Intents
extension CoolViewModel {
    
    func addCell(text: String, color: Color, offset: CGSize = .zero) {
        let cellModel = CellModel(text: text, color: color, offset: offset)
        cells.append(cellModel)
    }
    
    func bringCellToFront(_ cell: CellModel) {
        guard let index = cells.firstIndex(where: { $0.id == cell.id }) else { return }
        cells.remove(at: index)
        cells.append(cell)
    }
}

#if DEBUG
extension CoolViewModel {
    class var testModel: CoolViewModel {
        CoolViewModel(cells: testData)
    }
}

let testData = [
    CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: CGSize(width: 20, height: 40)),
    CellModel(text: "Cool View Cells Rock! 🎉🍾", color: Color.orange, offset: CGSize(width: 60, height: 100)),
]
#endif
