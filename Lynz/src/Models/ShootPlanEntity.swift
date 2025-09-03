import Foundation
import CoreData

@objc(ShootPlanEntity)
public class ShootPlanEntity: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShootPlanEntity> {
        return NSFetchRequest<ShootPlanEntity>(entityName: "ShootPlanEntity")
    }
    
    @NSManaged public var date: Date?
    @NSManaged public var role: String?
    @NSManaged public var tasks: Data?
}
