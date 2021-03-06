// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct AccessoryView: View {
    struct Height {
        static let compact: CGFloat = 80
        static let regular: CGFloat = 110
    }
    
    @EnvironmentObject var coolViewModel: CoolViewModel
    @Binding var text: String
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var height: CGFloat {
        return verticalSizeClass == .regular ? Height.regular : Height.compact
    }
    
    private var addButton: some View {
        Button(action: addCell) {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
                .font(.system(size: 22))
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .foregroundColor(.orange)
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.thickMaterial)
                .frame(height: height)
                .edgesIgnoringSafeArea([.leading, .trailing])
            
            HStack() {
                CoolTextField(text: $text)
                addButton
            }
            .frame(height: height - 40, alignment: .bottom)
            .frame(alignment: .bottom)
            .padding()
        }
    }
    
    private func addCell() {
        coolViewModel.addCell(text: text, color: .blue)
    }
}

#if DEBUG
struct AccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.orange
                AccessoryView(text: .constant("Hello, Hello, Hello! I am your beloved Count Olaf."))
            }
            
            ZStack {
                Color.brown
                AccessoryView(text: .constant("Hello, Hello, Hello! I am your beloved Count Olaf."))
            }
            .preferredColorScheme(.dark)
        }
        .frame(height: 80)
        .previewLayout(.sizeThatFits)
        .environmentObject(CoolViewModel.testModel)

        CoolView()
            .environmentObject(CoolViewModel.testModel)
    }
}
#endif
