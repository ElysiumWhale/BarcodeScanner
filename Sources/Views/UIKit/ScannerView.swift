import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding
    var result: Result<String, CameraError>

    @Binding
    var isScanning: Bool

    func makeUIViewController(context: Context) -> ScannerVC {
        let vc = ScannerVC()
        vc.scannerDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        if isScanning {
            uiViewController.startScan()
        }
    }

    func makeCoordinator() -> ScannerViewCoordinator {
        ScannerViewCoordinator(scannerView: self)
    }
}
