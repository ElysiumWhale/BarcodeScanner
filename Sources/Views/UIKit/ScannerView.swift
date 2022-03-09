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

    func makeCoordinator() -> CameraCoordinator {
        CameraCoordinator(scannerView: self)
    }
}

final class CameraCoordinator: ScannerVCDelegate {
    let scannerView: ScannerView

    init(scannerView: ScannerView) {
        self.scannerView = scannerView
    }

    func didFind(barcode: String) {
        scannerView.result = .success(barcode)
        scannerView.isScanning = false
    }

    func didFind(error: CameraError) {
        scannerView.result = .failure(error)
    }
}
