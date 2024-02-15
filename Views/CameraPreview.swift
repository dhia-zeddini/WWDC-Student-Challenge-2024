import SwiftUI
@available(macOS 14.0, iOS 17.0, tvOS 17.0, *)
struct CameraPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraViewController {
        return CameraViewController()
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {
        // This is intentionally left blank
    }
}
