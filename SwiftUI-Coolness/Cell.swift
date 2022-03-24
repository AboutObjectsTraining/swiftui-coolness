// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI


enum ColorPalette: String {
//    case primary
//    case secondary
//    case black
//    case white
//    case gray
    case brown
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case purple
//    case cyan
//    case mint
//    case pink
//    case teal
    
    var color: Color {
        switch self {
            case .brown: return Color.brown
            case .red: return Color.red
            case .orange: return Color.orange
            case .yellow: return Color.yellow
            case .green: return Color.green
            case .blue: return Color.blue
            case .indigo: return Color.indigo
            case .purple: return Color.purple
        }
    }
}

extension Color {
    var name: String {
        switch self {
            case .brown:  return ColorPalette.brown.rawValue
            case .red:    return ColorPalette.red.rawValue
            case .orange: return ColorPalette.orange.rawValue
            case .yellow: return ColorPalette.yellow.rawValue
            case .green:  return ColorPalette.green.rawValue
            case .blue:   return ColorPalette.blue.rawValue
            case .indigo: return ColorPalette.indigo.rawValue
            case .purple: return ColorPalette.purple.rawValue
            default: return defaultColorName
        }
    }
}

private let defaultColor = Color.black
private let defaultColorName = "black"
private let defaultOffset = CGSize.zero
private let defaultOffsetDict = ["Width": 0.0, "Height": 0.0]

struct Cell: Identifiable, Decodable {
    var id = UUID()
    var text: String
    var color: Color
    var offset: CGSize
    
    enum CodingKeys: CodingKey {
        case id
        case text
        case color
        case offset
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        
        let colorName = try container.decode(String.self, forKey: .color)
        let colorEnum = ColorPalette(rawValue: colorName)
        color = colorEnum?.color ?? defaultColor
        
        let size = try container.decode(Dictionary<String, Double>.self, forKey: .offset)
        offset = CGSize(dictionaryRepresentation: size as NSDictionary) ?? defaultOffset
    }
    
    init(text: String, color: Color, offset: CGSize) {
        self.text = text
        self.color = color
        self.offset = offset
    }
}

extension Cell: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(color.name, forKey: .color)
        let dict = offset.dictionaryRepresentation as? Dictionary<String, Double> ?? defaultOffsetDict
        try container.encode(dict, forKey: .offset)
    }
}
