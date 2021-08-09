import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var result: Result<String, CameraError> = .failure(.notScannedYet())
    
    @Published var isScanning = true
    
    var statusText: String {
        switch result {
            case .failure(let error):
                switch error {
                    case .invalidDeviceInput(let alert),
                         .invalidScannedValue(let alert),
                         .notScannedYet(alert: let alert):
                        return alert.title
                }
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
}
