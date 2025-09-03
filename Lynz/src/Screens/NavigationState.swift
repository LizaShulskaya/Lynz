import Foundation

@MainActor
class NavigationState: ObservableObject {
    @Published var popToCalendarToken: UUID? = nil

    func triggerPopToCalendar() {
        popToCalendarToken = UUID()
    }
}
