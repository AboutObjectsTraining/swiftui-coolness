// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolView: View {
    @State private var text = ""
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var viewModel: CoolViewModel
    
    var backgroundColor: Color {
        colorScheme == .light ? Color.orange : Color.brown
    }

    var body: some View {
        ZStack {
            backgroundColor
            
            VStack(spacing: 0) {
                AccessoryView(text: $text)
                CoolViewCellContainer()
            }
            .accentColor(Color.orange)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func addCell() {
        print("In \(#function), text is \(text)")
        viewModel.addCell(text: text, color: .blue)
    }
}

// MARK: Previews
#if DEBUG
struct CoolViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            CoolView()
            CoolView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(CoolViewModel.testModel)
        
//        ForEach(ColorScheme.allCases, id: \.self) {
//            CoolView.testView
//                .environment(\.colorScheme, $0)
//        }
    }
}
#endif
