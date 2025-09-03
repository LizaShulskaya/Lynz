import SwiftUI

struct AppColors {
 
    struct Text {
        static let primary = Color.white
        static let inverted = Color.black
        static let secondary = Color.white.opacity(0.3)
    }
    
    struct RoleColors {
        static let model = Color(hex: "#FFF45A")
        static let photographer = Color(hex: "#77B5F8")
        
        static func color(for role: Role) -> Color {
            switch role {
            case .model:
                return model
            case .photographer:
                return photographer
            }
        }
    }
    
    struct TabBar {
        static let unselected = Color.white.opacity(0.3)
        static let selected = Color(hex: "#FFF45A")
    }
    
    struct Background {
        static let primary = Color(hex: "#383838")
        static let secondary = Color(hex: "#515151")
        static let gradient = LinearGradient(
            colors: [primary, secondary],
            startPoint: .top,
            endPoint: .bottom
        )
        static let deleteButton = Color(hex: "#BC205C")
        static let white = Color.white
        static let clear = Color.clear
        static let selectedDate = Color.white.opacity(0.15)
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
