import Foundation

enum Role: String, CaseIterable, Codable, Identifiable {
    case model = "model"
    case photographer = "photographer"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .model: return "Model"
        case .photographer: return "Photographer"
        }
    }
    
    var assetName: String {
        switch self {
        case .model: return "ic_model"
        case .photographer: return "ic_photographer"
        }
    }
    
    var tasks: [String] {
        switch self {
        case .model:
            return [
                "Select outfit for the shoot",
                "Apply makeup and style hair",
                "Moisturize skin before the shoot",
                "Review pose references",
                "Bring makeup for touch-ups",
                "Prepare comfortable shoes",
                "Get enough sleep before the shoot",
                "Stay hydrated for a fresh look"
            ]
        case .photographer:
            return [
                "Charge the batteries",
                "Clear memory cards",
                "Prepare the camera and lenses",
                "Check tripod and lighting equipment",
                "Choose angles and plan shots",
                "Align concept with the model",
                "Gather pose references",
                "Bring spare batteries and cleaning supplies"
            ]
        }
    }
}
