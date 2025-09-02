import SwiftUI

struct PoseDetailView: View {
    
    let title: String
    let images: [String]
    @Environment(\.dismiss) private var dismiss
    @State private var index: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.gap16) {
            HStack(alignment: .firstTextBaseline) {
                Text(title)
                    .font(AppFonts.Style.calendarTitle)
                    .foregroundColor(AppColors.Text.primary)
                Spacer()
                Text("\(index + 1)/\(max(images.count, 1))")
                    .font(AppFonts.Style.monthTitle)
                    .foregroundColor(AppColors.Text.secondary)
            }
            .padding(.horizontal, AppSpacing.gap16)
            
            VStack(spacing: AppSpacing.gap16) {
                RoundedRectangle(cornerRadius: AppSpacing.Component.cardCornerRadius)
                    .fill(Color.clear)
                    .overlay(
                        Group {
                            if let img = images[safe: index] ?? images.first {
                                Image(img).resizable().scaledToFill()
                            } else {
                                Color.gray
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.Component.cardCornerRadius))
                    )
                    .frame(maxWidth: .infinity)
                
                HStack(spacing: AppSpacing.gap16) {
                    Button(action: {
                        if index > 0 {
                            index -= 1
                        }
                    }) {
                        Image("ic_button_left")
                    }
                    
                    Button(action: {
                        if index < images.count - 1 {
                            index += 1
                        }
                    }) {
                        Image("ic_button_right")
                    }
                }
            }
            Spacer()
        }
        .padding(.vertical, AppSpacing.gap20)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
        }
        .background(AppColors.Background.gradient)
    }
}
