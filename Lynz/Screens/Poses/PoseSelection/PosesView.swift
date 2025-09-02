import SwiftUI

struct PosesView: View {
    @StateObject private var viewModel = PosesViewModel()

    private let columns = [GridItem(.flexible(), spacing: AppSpacing.gap4), GridItem(.flexible(), spacing: AppSpacing.gap4)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppSpacing.gap4) {
                ForEach(viewModel.categories) { category in
                    NavigationLink(value: category) {
                        SelectionCard(imageName: category.imageName, title: category.title)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(AppSpacing.gap4)
        }
        .navigationTitle("Photo Poses")
        .navigationBarTitleDisplayMode(.large)
        .background(AppColors.Background.gradient)
        .navigationDestination(for: PoseCategory.self) { category in
            PoseDetailView(title: category.title, images: category.gallery)
        }
    }
}





// Safe index access
extension Collection {
    subscript(safe index: Index) -> Element? { indices.contains(index) ? self[index] : nil }
}


