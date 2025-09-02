import Foundation

struct ShootPlanTask: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
