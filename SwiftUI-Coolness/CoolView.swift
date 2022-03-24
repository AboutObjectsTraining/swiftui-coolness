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

struct CellContainer: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let cells: [Cell]
    
    var background: some View {
        Rectangle()
            .fill(.regularMaterial)
            .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
        ZStack {
            background
            Cells(cells: cells)
        }
        .clipped()
    }
}

struct Cells: View {
    let cells: [Cell]
    let topPadding: CGFloat = 40

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 30) {
                ForEach(self.cells) {
                    CoolViewCell(cell: $0)
                }
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height - topPadding,
                   alignment: .topLeading)
            .padding(.top, topPadding)
        }
    }
}

func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

// MARK: Previews
struct GroovyViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            CoolView()
                .environment(\.colorScheme, $0)
        }
    }
}
