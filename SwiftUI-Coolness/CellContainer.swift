// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

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

#if DEBUG
struct CellContainer_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            CoolView()
                .environment(\.colorScheme, $0)
        }
    }
}
#endif
