import Foundation

struct CalendarHelper {
    
    private let calendar = Calendar.current

    func daysInMonth(for date: Date) -> [Date?] {
        guard let startOfMonth = calendar.dateInterval(of: .month, for: date)?.start,
              let daysCount = calendar.range(of: .day, in: .month, for: date)?.count else {
            return []
        }

        // Сдвиг для первого дня недели
        let offset = calendar.component(.weekday, from: startOfMonth) - 1

        // Предыдущие даты для заполнения
        let leadingDays = offset > 0 ? (1...offset).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: startOfMonth)
        }.reversed() : []

        // Текущий месяц
        let currentDays = (0..<daysCount).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfMonth)
        }

        // Следующие даты для добивки
        let total = leadingDays.count + currentDays.count
        let trailingCount = (7 - (total % 7)) % 7
        let trailingDays = trailingCount > 0 ? (1...trailingCount).compactMap {
            calendar.date(byAdding: .day, value: daysCount + $0 - 1, to: startOfMonth)
        } : []

        return Array(leadingDays) + currentDays + trailingDays
    }
}


