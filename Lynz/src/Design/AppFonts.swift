import SwiftUI

struct AppFonts {

    struct Size {
        static let largeTitle: CGFloat = 34
        static let title: CGFloat = 24
        static let body: CGFloat = 17
        static let caption: CGFloat = 16
        static let subheadline: CGFloat = 15
    }
    
    struct Weight {
        static let bold = Font.Weight.bold
        static let semibold = Font.Weight.semibold
        static let light = Font.Weight.light
    }
    
    struct Style {
        // Calendar
        static let calendarTitle = Font.system(size: Size.largeTitle, weight: Weight.bold)
        static let monthTitle = Font.system(size: Size.title, weight: Weight.semibold)
        static let yearTitle = Font.system(size: Size.subheadline, weight: Weight.semibold)
        static let weekday = Font.system(size: Size.subheadline, weight: Weight.semibold)
        static let dayNumber = Font.system(size: Size.body, weight: Weight.light)
        
        // Navigation
        static let navigationSubtitle = Font.system(size: Size.subheadline, weight: Weight.semibold)
        
        // Buttons
        static let buttonLarge = Font.system(size: Size.body, weight: Weight.semibold)
        
        // Cards
        static let cardTitle = Font.system(size: Size.caption, weight: Weight.bold)
        
        // Tasks
        static let taskTitle = Font.system(size: Size.caption, weight: Weight.semibold)
    }
}
