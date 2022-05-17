// Copyright (C) 2019 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

extension Color {
    static let darkGray = Color(white: 0.2)
}

func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width,
                  height: lhs.height + rhs.height)
}

struct CoolViewCell: View {
    let cellModel: CellModel
    
    @EnvironmentObject var coolViewModel: CoolViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @GestureState private var offsetAmount =  CGSize.zero
    @State private var currentOffset = CGSize.zero
    
    @State private var isHighlighted = false
    @State private var isBouncing = false
    
    var textColor: Color {
        colorScheme == .light ? Color.white : Color.darkGray
    }
    
    var body: some View {
        
        let backgroundColor = cellModel.color
            .opacity(isHighlighted ? 0.5 : 1.0)
        
        let offset = offsetAmount + currentOffset + cellModel.offset
        
        Text(cellModel.text)
            .coolTextStyle(color: textColor, background: backgroundColor)
            .offset(offset)
            .gesture(drag)
            .rotationEffect(.degrees(isBouncing ? 90 : 0), anchor: .center)
            .bounceEffect(isBouncing)
            .onTapGesture(count: 1, perform: bringCellToFront)
            .onTapGesture(count: 2, perform: bounce)
    }
    
    private func bringCellToFront() {
        coolViewModel.bringCellToFront(cellModel)
    }
}

// MARK: - Drag gesture
extension CoolViewCell {
    
    var drag: some Gesture {
        DragGesture()
            .updating($offsetAmount) { value, state, _ in
                state = value.translation
            }
            .onChanged { _ in isHighlighted = true }
            .onEnded(updateOffset)
    }
    
    private func updateOffset(gesture: DragGesture.Value) {
        DispatchQueue.main.async {
            currentOffset = currentOffset + gesture.translation
        }
        isHighlighted = false
    }
}

// MARK: - View modifiers
extension Text {
    
    func coolTextStyle(color: Color, background: Color) -> some View {
        let border = RoundedRectangle(cornerRadius: 10)
            .stroke(color, lineWidth: 3)
        
        return self
            .font(.headline)
            .padding(.vertical, 9.0)
            .padding(.horizontal, 14.0)
            .foregroundColor(color)
            .background(background)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            .overlay(border)
    }
}

extension View {
    func bounceEffect(_ isBouncing: Bool) -> some View {
        modifier(BounceEffect(size: isBouncing ? 120 : 0))
    }
}


// MARK: - Animation
extension CoolViewCell {
    
    private static let duration = 1.0
    private static let repeatCount = 7
    
    private var animation: Animation {
        Animation
            .easeInOut(duration: Self.duration)
            .repeatCount(Self.repeatCount, autoreverses: true)
    }
    
    private var reverseAnimation: Animation {
        Animation.easeInOut(duration: Self.duration)
    }
        
    private func bounce() {
        withAnimation(self.animation) {
            self.isBouncing = true
        }
        
        let delay = Double(Self.repeatCount) * Self.duration
        
        // Note: SwiftUI doesn't currently provide animation completion callbacks.
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation(reverseAnimation) {
                isBouncing = false
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
            CoolViewCell(cellModel: CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            CoolViewCell(cellModel: CellModel(text: "Hello World! 🌍🌎🌏", color: Color.purple, offset: .zero))
                .preferredColorScheme(.dark)
            CoolView.testView
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
