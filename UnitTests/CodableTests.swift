// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest
import SwiftUI
@testable import SwiftUI_Coolness

let encoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    return encoder
}()
let decoder = JSONDecoder()

let cells = [
    CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: CGSize(width: 20, height: 0)),
    CellModel(text: "Cool View Cells Rock! 🎉🍾", color: Color.orange, offset: CGSize(width: 60, height: 0)),
]


class CodableTests: XCTestCase {

    func testEncodeCells() throws {
        let data = try encoder.encode(cells)
        let jsonString = String(data: data, encoding: .utf8)
        print(jsonString ?? "unable to encode \(cells)")
        XCTAssertTrue(jsonString!.contains(cells.first!.text))
    }
    
    func testDecodeCells() throws {
        let data = try encoder.encode(cells)
        let decodedCells = try decoder.decode([CellModel].self, from: data)
        print(decodedCells)
        XCTAssertEqual(decodedCells.count, cells.count)
    }
}
