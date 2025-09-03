import SwiftUI

struct TaskRow: View {
    
    @Binding var task: ShootPlanTask
    let roleColor: Color
    let mode: ShootPlanMode
    let onDelete: () -> Void

    @State private var isEditing = false

    var body: some View {
        HStack(spacing: AppSpacing.gap16) {
            Button(action: {
                task.isCompleted.toggle()
            }) {
                ZStack {
                    Circle().stroke(roleColor, lineWidth: AppSpacing.Component.checkboxStroke).frame(width: AppSpacing.Component.checkboxSize, height: AppSpacing.Component.checkboxSize)
                    if task.isCompleted {
                        Circle()
                        .fill(roleColor)
                        .frame(width: AppSpacing.Component.checkboxSize, height: AppSpacing.Component.checkboxSize) }
                }
            }
            .buttonStyle(.plain)
            .disabled(mode != .normal)

            if isEditing && mode == .editing {
                TextField("Task", text: $task.title, onCommit: {
                    isEditing = false
                })
                    .textFieldStyle(.plain)
                    .foregroundColor(AppColors.Text.primary)
                    .font(AppFonts.Style.taskTitle)
            } else {
                Text(task.title)
                    .foregroundColor(AppColors.Text.primary)
                    .font(AppFonts.Style.taskTitle)
                    .onTapGesture {
                        if mode == .editing {
                            isEditing = true
                        }
                    }
            }

            Spacer()

            if mode == .editing {
                Button(action: onDelete) {
                    Image(systemName: "xmark")
                        .foregroundColor(AppColors.Text.primary)
                }
                .buttonStyle(.plain)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

