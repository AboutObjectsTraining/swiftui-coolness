// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolView: View {
    @State private var text = ""
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel = CoolViewModel(cells: testData)
    
    var backgroundColor: Color {
        colorScheme == .light ? Color.orange : Color.brown
    }

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                AccessoryView(text: $text, addCell: addCell)
                CoolViewCellContainer(viewModel: viewModel)
            }
            .accentColor(Color.orange)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func addCell() {
        print("In \(#function), text is \(text)")
        let newModel = CellModel(text: text, color: .blue, offset: .zero)
        viewModel.cells.append(newModel)
    }
}

// MARK: Previews
#if DEBUG
struct CoolViewPreviews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            CoolView()
                .environment(\.colorScheme, $0)
        }
    }
}
#endif
