import SwiftUI

struct CalendarView: View {
    
    @StateObject private var viewModel = CalendarViewModel()
    @EnvironmentObject private var navigationState: NavigationState

    private let calendar = Calendar.current
    
    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    private let daysOfWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(AppFonts.Style.weekday)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(AppColors.Text.secondary)
                }
            }
            .padding(.horizontal, AppSpacing.gap20)
            .padding(.top, AppSpacing.gap16)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: AppSpacing.gap12) {
                ForEach(daysInMonth, id: \.self) { date in
                    if let date = date {
                        DayCell(
                            date: date,
                            isSelected: calendar.isDate(date, inSameDayAs: viewModel.selectedDate),
                            isCurrentMonth: calendar.isDate(date, equalTo: viewModel.currentMonth, toGranularity: .month),
                            roleMark: viewModel.getRole(for: date)
                        )
                    }
                }
            }
            .padding(.horizontal, AppSpacing.gap20)
            .padding(.top, AppSpacing.gap20)

            HStack {
                Button(action: previousMonth) {
                    Image("ic_button_left")
                }
                Spacer()
                VStack(spacing: AppSpacing.gap4) {
                    Text(monthString).font(AppFonts.Style.monthTitle)
                    Text(yearString)
                        .font(AppFonts.Style.yearTitle)
                        .foregroundColor(AppColors.Text.secondary)
                }
                Spacer()
                Button(action: nextMonth) {
                    Image("ic_button_right")
                }
            }
            .padding(.horizontal, AppSpacing.gap20)
            .padding(.top, AppSpacing.gap16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.large)
        .background(AppColors.Background.gradient)
        .navigationDestination(for: Date.self) { date in
            if let plan = viewModel.getPlan(for: date) {
                ShootPlanView(role: plan.role,
                              selectedDate: date,
                              initialTasks: plan.tasks,
                              onPlanChanged: {
                    viewModel.refreshPlans()
                })
                .environmentObject(navigationState)
            } else {
                RoleSelectionView(selectedDate: date, onPlanChanged: {
                    viewModel.refreshPlans()
                })
                .environmentObject(navigationState)
            }
        }
        .onAppear {
            viewModel.refreshPlans()
        }
    }

    private var monthString: String {
        monthFormatter.string(from: viewModel.currentMonth)
    }
    
    private var yearString: String {
        yearFormatter.string(from: viewModel.currentMonth)
    }

    private var daysInMonth: [Date?] {
        CalendarHelper().daysInMonth(for: viewModel.currentMonth)
    }

    private func previousMonth() {
        viewModel.previousMonth()
    }
    
    private func nextMonth() {
        viewModel.nextMonth()
    }
}






