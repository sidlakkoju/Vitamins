import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case kindaBlue
    
    
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
        }
    }
    
    var lightShadow: Color {
        switch self {
        case .kindaBlue: return Color("Kinda Blue LightShadow")
        }
    }
    
    var darkShadow: Color {
        switch self {
        case .kindaBlue: return Color("Kinda Blue LightShadow")
        }
    }
    
    var name: String {
        switch self {
        case .kindaBlue:
            return "Kinda Blue"
        }
    }
    
    var accentColor: Color {
        return Color("Kinda Blue Accents")
    }
    
    var id: String {
        name
    }
}
