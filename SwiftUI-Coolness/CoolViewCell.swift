// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

extension Color {
    static let darkGray = Color(white: 0.2)
}

struct CoolViewCell: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @GestureState private var offsetAmount =  CGSize.zero
    @State private var currentOffset = CGSize.zero
    @State private var bouncing = false
    
    let cellModel: CellModel
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
            .onEnded(updateOffset)
    }
    
    var body: some View {
        Text(cellModel.text)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(textColor)
            .padding(.vertical, 9.0)
            .padding(.horizontal, 14.0)
            .background(cellModel.color)
            .cornerRadius(10)
            .overlay(border)
            .offset(offsetAmount + currentOffset + cellModel.offset)
            .gesture(drag)
            .rotationEffect(.degrees(bouncing ? 90 : 0), anchor: .center)
            .modifier(bouncing ? BounceEffect(size: 120) : BounceEffect(size: 0))
            .onTapGesture(count: 2, perform: bounceAnimation)
    }
    
    private func updateOffset(gesture: DragGesture.Value) {
        DispatchQueue.main.async {
            self.currentOffset = self.currentOffset + gesture.translation
        }
    }
    
    private func bounceAnimation() {
        withAnimation(self.animation) {
            self.bouncing = true
        }
        // Note: SwiftUI doesn't currently provide an animation completion callback.
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
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

struct GroovyViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CoolViewCell(cellModel: CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .previewLayout(.sizeThatFits)
        CoolViewCell(cellModel: CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .environment(\.sizeCategory, .extraExtraExtraLarge)
            .previewLayout(.sizeThatFits)
        CoolViewCell(cellModel: CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
