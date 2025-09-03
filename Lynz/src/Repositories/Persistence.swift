import CoreData

final class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    private init(inMemory: Bool = false) {
        let model = NSManagedObjectModel()

        let planEntity = NSEntityDescription()
        planEntity.name = "ShootPlanEntity"
        planEntity.managedObjectClassName = "ShootPlanEntity"

        let planDateAttr = NSAttributeDescription()
        planDateAttr.name = "date"
        planDateAttr.attributeType = .dateAttributeType
        planDateAttr.isOptional = true

        let planRoleAttr = NSAttributeDescription()
        planRoleAttr.name = "role"
        planRoleAttr.attributeType = .stringAttributeType
        planRoleAttr.isOptional = true

        let planTasksAttr = NSAttributeDescription()
        planTasksAttr.name = "tasks"
        planTasksAttr.attributeType = .binaryDataAttributeType
        planTasksAttr.isOptional = true

        planEntity.properties = [planDateAttr, planRoleAttr, planTasksAttr]

        model.entities = [planEntity]

        container = NSPersistentContainer(name: "LynzModel", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error: \(error)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    func saveContext() {
        let ctx = container.viewContext
        if ctx.hasChanges {
            do { try ctx.save() } catch { print("CoreData save error: \(error)") }
        }
    }
}


