import Foundation

enum CameraError: Error {
    case invalidDeviceInput(alert: AlertItem = AlertItem.invalidDeviceInput)
    case invalidScannedValue(alert: AlertItem = AlertItem.invalidScannedValue)
    case notScannedYet(alert: AlertItem = AlertItem.notScannedYet)

    var alertTitle: String {
        switch self {
            case .invalidDeviceInput(let alert),
                    .invalidScannedValue(let alert),
                    .notScannedYet(let alert):
                return alert.title.localized
        }
    }

    var alertMessage: String {
        switch self {
            case .invalidDeviceInput(let alert),
                    .invalidScannedValue(let alert),
                    .notScannedYet(let alert):
                return alert.message.localized
        }
    }
}
