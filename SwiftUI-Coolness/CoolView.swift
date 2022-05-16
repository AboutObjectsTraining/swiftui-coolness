// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolView: View {
    @State private var text = ""
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var store = CellStore(cells: testData)
    
    var backgroundColor: Color {
        colorScheme == .light ? Color.orange : Color.brown
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                AccessoryView(text: $text, addCell: addCell)
                CellContainer(cells: store.cells)
            }
            .accentColor(Color.orange)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func addCell() {
        print("In \(#function), text is \(text)")
        let newModel = Cell(text: text, color: .blue, offset: .zero)
        store.cells.append(newModel)
    }
}

// MARK: Previews
struct CoolViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            CoolView()
                .environment(\.colorScheme, $0)
        }
    }
}
