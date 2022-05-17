// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolViewCellContainer: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var background: some View {
        Rectangle()
            .fill(.regularMaterial)
            .edgesIgnoringSafeArea(.all)
    }
    
    var body: some View {
        ZStack {
            background
            CoolViewCells()
        }
        .clipped()
    }
}

struct CoolViewCells: View {
    @EnvironmentObject var viewModel: CoolViewModel
    let topPadding: CGFloat = 40
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height - topPadding
            
            ZStack(alignment: .leading) {
                ForEach(viewModel.cells) {
                    CoolViewCell(cellModel: $0)
                }
            }
            .frame(width: width, height: height, alignment: .topLeading)
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
