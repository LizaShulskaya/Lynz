import Foundation

struct ShootPlan: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let role: Role
    var tasks: [ShootPlanTask]
    
    init(date: Date,
         role: Role,
         tasks: [ShootPlanTask] = []) {
        self.date = date
        self.role = role
        self.tasks = tasks
    }
}


