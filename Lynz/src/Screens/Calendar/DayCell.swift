import SwiftUI

struct DayCell: View {
    
    let date: Date
    let isSelected: Bool
    let isCurrentMonth: Bool
    let roleMark: Role?
    
    private let calendar = Calendar.current

    var body: some View {
        NavigationLink(value: date) {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: AppSpacing.Component.dayCellCornerRadius)
                        .fill(AppColors.Background.selectedDate)
                        .frame(width: AppSpacing.Component.dayCellSize, height: AppSpacing.Component.dayCellSize)
                }
                if let roleMark = roleMark {
                    RoundedRectangle(cornerRadius: AppSpacing.Component.dayCellCornerRadius)
                        .stroke(AppColors.RoleColors.color(for: roleMark), lineWidth: 1)
                        .frame(width: AppSpacing.Component.dayCellSize, height: AppSpacing.Component.dayCellSize)
                }
                
                Text("\(calendar.component(.day, from: date))")
                    .font(AppFonts.Style.dayNumber)
                    .foregroundColor(isCurrentMonth ? AppColors.Text.primary : AppColors.Text.secondary)
            }
            .frame(width: AppSpacing.Component.dayCellSize, height: AppSpacing.Component.dayCellSize)
        }
        .buttonStyle(.plain)
    }
}
