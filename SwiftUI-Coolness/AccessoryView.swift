// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var isClearButtonVisible: Bool {
        isFocused && !text.isEmpty
    }
    
    var clearButtonImage: some View {
        Image(systemName: "multiply.circle.fill")
            .foregroundColor(.gray)
            .opacity(1)
            .imageScale(.large)
            .padding(.horizontal, 6)
            .background(colorScheme == .light ? .white : .black)
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField("Enter text",
                      text: self.$text,
                      prompt: Text("Enter a label"))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .focused($isFocused)
            
            if isClearButtonVisible {
                Button(action: clear,
                       label: { clearButtonImage })
            }
        }
    }
    
    private func clear() {
        text = ""
    }
}

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
                }
            }
            .frame(height: height - 40, alignment: .bottom)
            .padding()
        }
    }
}

struct AccessoryView_Previews: PreviewProvider {
    static var previews: some View {
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
}
