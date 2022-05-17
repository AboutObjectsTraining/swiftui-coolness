// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

extension Color {
    static let darkGray = Color(white: 0.2)
}

func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

struct CoolViewCell: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @GestureState private var offsetAmount =  CGSize.zero
    @State private var isHighlighted = false
    @State private var currentOffset = CGSize.zero
    @State private var bouncing = false
    
    let cell: Cell
    
    static let duration = 1.0
    static let repeatCount = 7
    
    let animation = Animation
        .easeInOut(duration: duration)
        .repeatCount(repeatCount, autoreverses: true)
    let reverseAnimation = Animation.easeInOut(duration: duration)
    
    var textColor: Color {
        colorScheme == .light ? Color.white : Color.darkGray
    }
    
    var border: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(textColor, lineWidth: 3)
    }
    
    var drag: some Gesture {
        DragGesture()
            .updating($offsetAmount) { value, state, _ in
                state = value.translation
            }
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
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            .offset(offsetAmount + currentOffset + cell.offset)
            .gesture(drag)
            .rotationEffect(.degrees(bouncing ? 90 : 0), anchor: .center)
            .modifier(bouncing ? BounceEffect(size: 120) : BounceEffect(size: 0))
            .onTapGesture(count: 2, perform: bounce)
    }
}

// MARK: Operations
extension CoolViewCell {
    
    private func updateOffset(gesture: DragGesture.Value) {
        DispatchQueue.main.async {
            self.currentOffset = self.currentOffset + gesture.translation
        }
        isHighlighted = false
    }
    
    private func bounce() {
        withAnimation(self.animation) {
            self.bouncing = true
        }
        
        let delay = Double(Self.repeatCount) * Self.duration
        
        // Note: SwiftUI doesn't currently provide animation completion callbacks.
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
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

#if DEBUG
struct CoolViewCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        CoolViewCell(cell: Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
        CoolViewCell(cell: Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .environment(\.sizeCategory, .extraExtraExtraLarge)
        CoolViewCell(cell: Cell(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
            .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
