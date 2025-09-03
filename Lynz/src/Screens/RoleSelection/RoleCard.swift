import SwiftUI

struct RoleCard: View {
    
    let role: Role
    
    var body: some View {
        NavigationLink(value: role) {
            ZStack(alignment: .bottom) {
                Image(role.assetName)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                HStack {
                    Text(role.displayName)
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
                        .padding(.trailing, AppSpacing.gap20)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: AppSpacing.Component.cardCornerRadius))
        }
        .buttonStyle(.plain)
    }
}
