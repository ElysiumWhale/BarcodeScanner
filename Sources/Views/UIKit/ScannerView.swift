import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding
    var result: Result<String, CameraError>

    @Binding
    var isScanning: Bool

    @ObservedObject
    var codeTypesList: CodeElementsListViewModel

    private var codeTypes: [CodeType] {
        codeTypesList.selectedCodeTypes.map { $0.type }
    }

    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC().withDelegate(context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        if isScanning {
            uiViewController.startScan(with: codeTypes)
        }
    }

    func makeCoordinator() -> ScannerViewCoordinator {
        ScannerViewCoordinator(scannerView: self)
    }
}
