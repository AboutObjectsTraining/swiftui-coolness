// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolViewCellContainer: View {
    @ObservedObject var viewModel: CoolViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var background: some View {
        Rectangle()
            .fill(.regularMaterial)
            .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
        ZStack {
            background
            CoolViewCells(cells: viewModel.cells)
        }
        .clipped()
    }
}

struct CoolViewCells: View {
    let cells: [CellModel]
    let topPadding: CGFloat = 40
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height - topPadding
            
            VStack(alignment: .leading, spacing: 30) {
                ForEach(cells) {
                    CoolViewCell(cellModel: $0)
                }
            }
            .frame(width: width, height: height, alignment: .topLeading)
            .padding(.top, topPadding)
        }
    }
}

#if DEBUG
struct CoolViewCellContainer_Previews: PreviewProvider {
    static var previews: some View {
        CoolView()
        CoolView()
            .preferredColorScheme(.dark)
    }
}
#endif
