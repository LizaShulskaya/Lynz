import Foundation

struct PoseCategory: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let gallery: [String]
    
    init(title: String, imageName: String, gallery: [String]) {
        self.title = title
        self.imageName = imageName
        self.gallery = gallery
    }
}
