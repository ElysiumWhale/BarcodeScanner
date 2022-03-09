import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published
    var result: Result<String, CameraError> = .failure(.notScannedYet())

    @Published
    var isScanning = true

    var statusText: String {
        switch result {
            case .failure(let error):
                return error.alertTitle
            case .success(let code):
                return code
        }
    }

    var statusTextColor: Color {
        switch result {
            case .success:
                return .green
            case .failure:
                return .red
        }
    }

    func scanAgain() {
        isScanning = true
        result = .failure(.notScannedYet())
    }
}
