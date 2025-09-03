import SwiftUI

struct SelectionCard: View {
    
    let imageName: String
    let title: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .clipped()

            HStack {
                Text(title)
                    .font(AppFonts.Style.cardTitle)
                    .foregroundColor(AppColors.Text.inverted)
                Spacer()
            }
            .padding(AppSpacing.gap16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(AppColors.Background.white)
            .overlay(alignment: .trailing) {
                Image("ic_chevron_right")
                    .offset(y: -AppSpacing.Component.buttonHeight / 2)
                    .padding(.trailing, AppSpacing.gap16)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: AppSpacing.Component.cardCornerRadius))
    }
}
