import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject private var navigationState: NavigationState
    let selectedDate: Date
    let onPlanChanged: (() -> Void)?
    
    init(selectedDate: Date, onPlanChanged: (() -> Void)? = nil) {
        self.selectedDate = selectedDate
        self.onPlanChanged = onPlanChanged
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.gap16) {
                Text("shoot: \(dateFormatter.string(from: selectedDate))")
                    .font(AppFonts.Style.navigationSubtitle)
                    .foregroundColor(AppColors.Text.secondary)
                
                VStack(spacing: AppSpacing.gap4) {
                    ForEach(Role.allCases) { role in
                        RoleCard(role: role)
                    }
                }
            }
            .padding(AppSpacing.gap20)
        }
        .navigationTitle("Choose Your Role")
        .navigationBarTitleDisplayMode(.large)
        .tint(.white)
        .background(AppColors.Background.gradient)
        .navigationDestination(for: Role.self) { role in
            ShootPlanView(role: role, selectedDate: selectedDate, onPlanChanged: onPlanChanged)
                .environmentObject(navigationState)
        }
    }
}




