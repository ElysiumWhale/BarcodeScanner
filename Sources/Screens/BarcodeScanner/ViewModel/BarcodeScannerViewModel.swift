import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published
    var result: Result<String, CameraError> = .failure(.notScannedYet())

    @Published
    var isScanning = true

    @Published
    var listViewModel = CodeElementsListViewModel()

    var isSuccess: Bool {
        guard (try? result.get()) != nil else {
            return false
        }

        return true
    }

    var statusText: (title: String, message: String) {
        switch result {
            case .failure(let error):
                return (error.alertTitle, error.alertMessage)
            case .success(let code):
                return (code, .empty)
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
