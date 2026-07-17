import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case green = "Opal Green"
    case red = "Crimson Red"
    case purple = "Royal Purple"
    case beige = "Classic Beige"
    case blue = "Ocean Blue"
    case orange = "Sunset Orange"
    case pink = "Rose Pink"
    
    var id: String { self.rawValue }
    
    var shortName: String {
        switch self {
        case .green: return "Green"
        case .red: return "Red"
        case .purple: return "Purple"
        case .beige: return "Beige"
        case .blue: return "Blue"
        case .orange: return "Orange"
        case .pink: return "Pink"
        }
    }
    
    var accentColor: Color {
        switch self {
        case .green:  return Color(red: 0.4, green: 0.9, blue: 0.7)
        case .red:    return Color(red: 0.9, green: 0.3, blue: 0.3)
        case .purple: return Color(red: 0.6, green: 0.4, blue: 0.9)
        case .beige:  return Color(red: 0.9, green: 0.8, blue: 0.6)
        case .blue:   return Color(red: 0.3, green: 0.7, blue: 0.9)
        case .orange: return Color(red: 0.9, green: 0.6, blue: 0.3)
        case .pink:   return Color(red: 0.9, green: 0.4, blue: 0.6)
        }
    }
    
    var gradientColors: [Color] {
        switch self {
        case .green:  return [Color(red: 12/255, green: 38/255, blue: 25/255), .black]
        case .red:    return [Color(red: 38/255, green: 12/255, blue: 12/255), .black]
        case .purple: return [Color(red: 25/255, green: 12/255, blue: 38/255), .black]
        case .beige:  return [Color(red: 30/255, green: 28/255, blue: 24/255), .black]
        case .blue:   return [Color(red: 12/255, green: 25/255, blue: 38/255), .black]
        case .orange: return [Color(red: 38/255, green: 24/255, blue: 12/255), .black]
        case .pink:   return [Color(red: 38/255, green: 12/255, blue: 25/255), .black]
        }
    }
    
    var accentGradientColors: [Color] {
        switch self {
        case .green:
            return [Color(red: 168/255, green: 255/255, blue: 217/255), Color(red: 102/255, green: 230/255, blue: 180/255)]
        case .red:
            return [Color(red: 255/255, green: 123/255, blue: 123/255), Color(red: 230/255, green: 80/255, blue: 80/255)]
        case .purple:
            return [Color(red: 226/255, green: 201/255, blue: 255/255), Color(red: 180/255, green: 120/255, blue: 255/255)]
        case .beige:
            return [Color(red: 255/255, green: 236/255, blue: 201/255), Color(red: 255/255, green: 201/255, blue: 158/255)]
        case .blue:
            return [Color(red: 169/255, green: 215/255, blue: 255/255), Color(red: 70/255, green: 160/255, blue: 245/255)]
        case .orange:
            return [Color(red: 255/255, green: 197/255, blue: 123/255), Color(red: 255/255, green: 135/255, blue: 50/255)]
        case .pink:
            return [Color(red: 255/255, green: 168/255, blue: 217/255), Color(red: 255/255, green: 130/255, blue: 170/255)]
        }
    }
}
