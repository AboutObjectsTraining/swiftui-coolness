// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

extension Color {
    static let darkGray = Color(white: 0.2)
}

struct CoolViewCell: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @GestureState private var offsetAmount =  CGSize.zero
    @State private var isHighlighted = false
    @State private var currentOffset = CGSize.zero
    @State private var bouncing = false
    
    let cell: Cell
    let animation = Animation
        .easeInOut(duration: 1)
        .repeatCount(7, autoreverses: true)
    let reverseAnimation = Animation.easeInOut(duration: 1)
    
    var textColor: Color {
        colorScheme == .light ? Color.white : Color.darkGray
    }
    
    var border: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(textColor, lineWidth: 3)
    }
    
    var drag: some Gesture {
        DragGesture()
            .updating($offsetAmount) { value, state, _ in state = value.translation }
            .onChanged { _ in isHighlighted = true }
            .onEnded(updateOffset)
    }
        
    var body: some View {
        Text(cell.text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(textColor)
            .padding(.vertical, 9.0)
            .padding(.horizontal, 14.0)
            .background(cell.color.opacity(isHighlighted ? 0.5 : 1.0))
            .cornerRadius(10)
            .overlay(border)
            .offset(offsetAmount + currentOffset + cell.offset)
            .gesture(drag)
            .rotationEffect(.degrees(bouncing ? 90 : 0), anchor: .center)
            .modifier(bouncing ? BounceEffect(size: 120) : BounceEffect(size: 0))
            .onTapGesture(count: 2, perform: bounceAnimation)
    }
    
    private func updateOffset(gesture: DragGesture.Value) {
        DispatchQueue.main.async {
            self.currentOffset = self.currentOffset + gesture.translation
        }
        isHighlighted = false
    }
    
    private func bounceAnimation() {
        withAnimation(self.animation) {
            self.bouncing = true
        }
        
        // Note: SwiftUI doesn't currently provide an animation completion callback.
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
            withAnimation(self.reverseAnimation) {
                self.bouncing = false
            }
        }
    }
}

struct BounceEffect: GeometryEffect {
    var size: CGFloat
    
    var animatableData: CGSize.AnimatableData {
        get { CGSize.AnimatableData(size, size * 2) }
        set { size = newValue.first }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = CGAffineTransform(translationX: animatableData.first,
                                            y: animatableData.second)
        return ProjectionTransform(translation)
    }
}

struct CoolViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CoolViewCell(cell: Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .previewLayout(.sizeThatFits)
        CoolViewCell(cell: Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .environment(\.sizeCategory, .extraExtraExtraLarge)
            .previewLayout(.sizeThatFits)
        CoolViewCell(cell: Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
