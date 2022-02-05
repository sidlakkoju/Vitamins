import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case kindaBlue
    case veryPurple
    case whatsGreen
    
    
    //Can use when multiple color options are available in the future
    /*
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
     */
    
    var mainColor: Color {
        switch self {
        case .kindaBlue: return Color("Kinda Blue")
        case .veryPurple: return Color("Very Purple")
        case .whatsGreen: return Color("Whats Green?")
        }
    }
    
    var lightShadow: Color {
        switch self {
        case .kindaBlue: return Color("Kinda Blue LightShadow")
        case .whatsGreen: return Color("Whats Green? LightShadow")
        case .veryPurple: return Color("Very Purple LightShadow")
        }
    }
    
    var darkShadow: Color {
        switch self {
        case .kindaBlue: return Color("Kinda Blue LightShadow")
        case .whatsGreen: return Color("Whats Green? DarkShadow")
        case .veryPurple: return Color("Very Purple DarkShadow")
        }
    }
    
    var name: String {
        switch self {
        case .kindaBlue:
            return "Kinda Blue"
        case .veryPurple: return "Very Purple"
        case .whatsGreen: return "What's Green?"
        }
    }
    
    var accentColor: Color {
        return Color("Kinda Blue Accents")
    }
    
    var id: String {
        name
    }
}
