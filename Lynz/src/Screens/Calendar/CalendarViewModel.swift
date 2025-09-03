import Foundation
import SwiftUI
import CoreData

@MainActor
class CalendarViewModel: ObservableObject {
    
    @Published var selectedDate = Date()
    @Published var currentMonth = Date()
    @Published var plans: [ShootPlan] = []
    
    private let planRepository: ShootPlanRepositoryProtocol
    private let calendar = Calendar.current
    
    init(planRepository: ShootPlanRepositoryProtocol = ShootPlanRepository()) {
        self.planRepository = planRepository
        loadPlans()
    }
    
    func selectDate(_ date: Date) {
        selectedDate = date
    }
    
    func previousMonth() {
        currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }
    
    func nextMonth() {
        currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }
    
    func getPlan(for date: Date) -> ShootPlan? {
        return plans.first {
            calendar.isDate($0.date, inSameDayAs: date)
        }
    }
    
    func hasPlan(for date: Date) -> Bool {
        return plans.contains {
            calendar.isDate($0.date, inSameDayAs: date) }
        
    }
    
    func getRole(for date: Date) -> Role? {
        return plans.first {
            calendar.isDate($0.date, inSameDayAs: date)
        }?.role
    }
    
    func refreshPlans() {
        loadPlans()
    }
    
    private func loadPlans() {
        let plansDictionary = planRepository.loadShootPlans()
        plans = Array(plansDictionary.values)
    }
}
