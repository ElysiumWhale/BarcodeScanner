import Foundation

final class ScannerViewCoordinator: ScannerVCDelegate {
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
