// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private var isClearButtonVisible: Bool {
        isFocused && !text.isEmpty
    }
    
    private func clearButtonImage() -> some View {
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
                Button(action: clear, label: clearButtonImage)
            }
        }
    }
}

// MARK: - Intents
extension CoolTextField {
    private func clear() {
        text = ""
    }
}

struct CoolTextField_Previews: PreviewProvider {
    @State static var string: String = "Here's some text"
    
    static var field: some View {
        VStack {
            CoolTextField(text: $string)
                .padding()
        }
        .frame(height: 100)
        .background(.brown.opacity(0.3))
    }
    
    static var previews: some View {
        Group {
            field
            field
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
