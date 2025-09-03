import Foundation
import CoreData

protocol ShootPlanRepositoryProtocol {
    func loadShootPlans() -> [Date: ShootPlan]
    func saveShootPlan(_ plan: ShootPlan)
    func deleteShootPlan(for date: Date)
    func getShootPlan(for date: Date) -> ShootPlan?
}

class ShootPlanRepository: ShootPlanRepositoryProtocol {
    private let persistenceController = PersistenceController.shared
    
    func loadShootPlans() -> [Date: ShootPlan] {
        let context = persistenceController.container.viewContext
        let request: NSFetchRequest<ShootPlanEntity> = ShootPlanEntity.fetchRequest()
        
        do {
            let entities = try context.fetch(request)
            var shootPlans: [Date: ShootPlan] = [:]
            
            for entity in entities {
                guard let date = entity.date,
                      let roleString = entity.role,
                      let role = Role(rawValue: roleString),
                      let tasksData = entity.tasks else { 
                    continue 
                }
                
                let tasks = try JSONDecoder().decode([ShootPlanTask].self, from: tasksData)
                let plan = ShootPlan(date: date, role: role, tasks: tasks)
                shootPlans[date] = plan
            }
            
            return shootPlans
        } catch {
            print("Error loading ShootPlans: \(error)")
            return [:]
        }
    }
    
    func saveShootPlan(_ ShootPlan: ShootPlan) {
        let context = persistenceController.container.viewContext
        
        deleteShootPlan(for: ShootPlan.date)
        
        let entity = ShootPlanEntity(context: context)
        entity.date = ShootPlan.date
        entity.role = ShootPlan.role.rawValue
        
        do {
            let tasksData = try JSONEncoder().encode(ShootPlan.tasks)
            entity.tasks = tasksData
            try context.save()
        } catch {
            print("Error saving ShootPlan: \(error)")
        }
    }
    
    func deleteShootPlan(for date: Date) {
        let context = persistenceController.container.viewContext
        let request: NSFetchRequest<ShootPlanEntity> = ShootPlanEntity.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", date as NSDate)
        
        do {
            let entities = try context.fetch(request)
            for entity in entities {
                context.delete(entity)
            }
            try context.save()
        } catch {
            print("Error deleting ShootPlan: \(error)")
        }
    }
    
    func getShootPlan(for date: Date) -> ShootPlan? {
        let context = persistenceController.container.viewContext
        let request: NSFetchRequest<ShootPlanEntity> = ShootPlanEntity.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", date as NSDate)
        
        do {
            guard let entity = try context.fetch(request).first,
                  let roleString = entity.role,
                  let role = Role(rawValue: roleString),
                  let tasksData = entity.tasks else { return nil }
            
            let tasks = try JSONDecoder().decode([ShootPlanTask].self, from: tasksData)
            return ShootPlan(date: date, role: role, tasks: tasks)
        } catch {
            print("Error getting ShootPlan: \(error)")
            return nil
        }
    }
}
