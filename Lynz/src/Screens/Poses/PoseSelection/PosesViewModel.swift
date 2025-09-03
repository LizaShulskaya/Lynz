import Foundation
import SwiftUI

@MainActor
class PosesViewModel: ObservableObject {
    
    @Published var categories: [PoseCategory] = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        categories = [
            PoseCategory(
                title: "Standing",
                imageName: "Standing",
                gallery: (1...8).map { "standing_\($0)" }
            ),
            PoseCategory(
                title: "Laying Down",
                imageName: "Laying_down",
                gallery: (1...8).map { "laying_\($0)" }
            ),
            PoseCategory(
                title: "Sitting",
                imageName: "Sitting",
                gallery: (1...7).map { "sitting_\($0)" }
            ),
            PoseCategory(
                title: "Close-up",
                imageName: "Close_up",
                gallery: (1...8).map { "Portrait_\($0)" }
            )
        ]
    }
}
