import SwiftUI

struct ShootPlanView: View {
    
    @StateObject private var viewModel: ShootPlanViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var navigationState: NavigationState
    @FocusState private var newTaskFocused: Bool

    init(role: Role,
         selectedDate: Date,
         initialTasks: [ShootPlanTask] = [],
         onPlanChanged: (() -> Void)? = nil) {
        let viewModel = ShootPlanViewModel(role: role, selectedDate: selectedDate, initialTasks: initialTasks)
        viewModel.onPlanChanged = onPlanChanged
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    private var roleColor: Color {
        AppColors.RoleColors.color(for: viewModel.role)
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: AppSpacing.gap16) {
                HStack(alignment: .top) {
                    Text("Choose Plan")
                        .font(AppFonts.Style.calendarTitle)
                        .foregroundColor(AppColors.Text.primary)
                    Spacer()
                    HStack(spacing: AppSpacing.gap20) {
                        Button(action: {
                            viewModel.mode = (viewModel.mode == .editing ? .normal : .editing)
                        }) {
                            Image(viewModel.mode == .editing ? 
                                  (viewModel.role == .model ? "ic_done_model" : "ic_done_photographer") : 
                                  "ic_edit")
                        }
                        .buttonStyle(.plain)
                        
                        Button(action: {
                            if viewModel.mode == .adding { 
                                viewModel.addNewTask() 
                            } else { 
                                viewModel.mode = .adding
                                newTaskFocused = true 
                            }
                        }) {
                            Image(viewModel.mode == .adding ? 
                                  (viewModel.role == .model ? "ic_done_model" : "ic_done_photographer") : 
                                  "ic_add")
                        }
                        .buttonStyle(.plain)
                    }
                }
                
                HStack {
                    Text("shoot: \(dateFormatter.string(from: viewModel.selectedDate))")
                        .font(AppFonts.Style.navigationSubtitle)
                        .foregroundColor(AppColors.Text.secondary)
                    Spacer()
                    Text("role: \(viewModel.role.rawValue.uppercased())")
                        .font(AppFonts.Style.navigationSubtitle)
                        .foregroundColor(AppColors.Text.secondary)
                }
            }
            .padding(AppSpacing.gap20)
            

            ScrollView {
                VStack(spacing: AppSpacing.gap16) {
                    ForEach($viewModel.tasks) { $task in
                        TaskRow(task: $task, roleColor: roleColor, mode: viewModel.mode) {
                            viewModel.deleteTask(task)
                        }
                    }
                    
                    if viewModel.mode == .adding {
                        HStack(spacing: 12) {
                            Circle().stroke(roleColor, lineWidth: 1.5)
                                .frame(width: 24, height: 24)
                            VStack(spacing: 6) {
                                HStack {
                                    TextField("Write new point", text: $viewModel.newTaskTitle)
                                        .focused($newTaskFocused)
                                        .textInputAutocapitalization(.sentences)
                                        .disableAutocorrection(false)
                                        .onSubmit {
                                            viewModel.addNewTask()
                                        }
                                    Button(action: {
                                        viewModel.cancelAdd()
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                    }
                                    .buttonStyle(.plain)
                                }
                                Rectangle()
                                    .fill(roleColor)
                                    .frame(height: 1)
                            }
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.gap20)
                .padding(.top, 4)
                .padding(.bottom, AppSpacing.gap20)
            }

            Button(action: {
                switch viewModel.mode {
                case .normal:
                    viewModel.savePlan()
                    navigationState.triggerPopToCalendar()
                case .editing:
                    viewModel.deletePlan()
                    navigationState.triggerPopToCalendar()
                case .adding:
                    viewModel.addNewTask()
                }
            }) {
                Text(viewModel.mode == .editing ? "Delete Plan" : "Done")
                    .font(AppFonts.Style.buttonLarge)
                    .foregroundColor(AppColors.Text.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: AppSpacing.Component.buttonHeight)
                    .background(
                        RoundedRectangle(cornerRadius: AppSpacing.Component.buttonCornerRadius)
                            .fill(viewModel.mode == .editing ? AppColors.Background.deleteButton : AppColors.Background.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: AppSpacing.Component.buttonCornerRadius)
                            .stroke(AppColors.Background.white, lineWidth: viewModel.mode == .editing ? 0 : 1)
                    )
                    .padding(.horizontal, AppSpacing.gap20)
                    .padding(.bottom, AppSpacing.gap20)
            }
            .disabled(viewModel.mode == .adding && viewModel.newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigationState.triggerPopToCalendar()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
        }
        .background(AppColors.Background.gradient)
    }
}





