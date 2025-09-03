import Foundation
import CoreData
import SwiftUI

enum ShootPlanMode {
    case normal
    case editing
    case adding
}

@MainActor
class ShootPlanViewModel: ObservableObject {
    
    @Published var tasks: [ShootPlanTask] = []
    @Published var mode: ShootPlanMode = .normal
    @Published var newTaskTitle = ""
    
    let role: Role
    let selectedDate: Date
    
    private let planRepository: ShootPlanRepositoryProtocol

    var onPlanChanged: (() -> Void)?
    
    init(role: Role,
         selectedDate: Date,
         initialTasks: [ShootPlanTask] = [],
         planRepository: ShootPlanRepositoryProtocol = ShootPlanRepository()) {
        self.role = role
        self.selectedDate = selectedDate
        self.planRepository = planRepository
        
        if initialTasks.isEmpty {
            self.tasks = role.tasks.map {
                ShootPlanTask(title: $0)
            }
        } else {
            self.tasks = initialTasks
        }
    }
    
    func toggleTaskCompletion(_ task: ShootPlanTask) {
        guard let index = tasks.firstIndex(where: {
            $0.id == task.id
        })
        else {
            return
        }
        tasks[index].isCompleted.toggle()
    }
    
    func updateTaskTitle(_ task: ShootPlanTask, newTitle: String) {
        guard let index = tasks.firstIndex(where: {
            $0.id == task.id
        })
        else {
            return
        }
        tasks[index].title = newTitle
    }
    
    func deleteTask(_ task: ShootPlanTask) {
        tasks.removeAll { $0.id == task.id }
    }
    
    func addNewTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        let newTask = ShootPlanTask(title: trimmed)
        tasks.append(newTask)
        newTaskTitle = ""
        mode = .normal
    }
    
    func cancelAdd() {
        newTaskTitle = ""
        mode = .normal
    }
    
    func savePlan() {
        let plan = ShootPlan(date: selectedDate, role: role, tasks: tasks)
        planRepository.saveShootPlan(plan)
        onPlanChanged?()
    }
    
    func deletePlan() {
        planRepository.deleteShootPlan(for: selectedDate)
        onPlanChanged?()
    }
}
