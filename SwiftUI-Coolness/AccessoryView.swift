// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct AccessoryView: View {
    struct Height {
        static let compact: CGFloat = 80
        static let regular: CGFloat = 110
    }
    
    @Binding var text: String
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var addCell: () -> Void
    
    var height: CGFloat {
        return verticalSizeClass == .regular ? Height.regular : Height.compact
    }
        
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.thickMaterial)
                .frame(height: height)
                .edgesIgnoringSafeArea([.leading, .trailing])
            
            HStack() {
                CoolTextField(text: $text)
                Button(action: addCell) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .font(.system(size: 22))
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .foregroundColor(.orange)
                }
            }
            .frame(height: height - 40, alignment: .bottom)
            .padding()
        }
    }
}

#if DEBUG
struct AccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color.orange
                AccessoryView(text: .constant("Hello, Hello, Hello! I am your beloved Count Olaf."), addCell: {} )
            }
            
            ZStack {
                Color.brown
                AccessoryView(text: .constant("Hello, Hello, Hello! I am your beloved Count Olaf."), addCell: {} )
            }
            .preferredColorScheme(.dark)
        }
        .frame(height: 80)
        .previewLayout(.sizeThatFits)
    }
}
#endif
