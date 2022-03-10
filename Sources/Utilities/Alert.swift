import Foundation

struct AlertItem {
    let title: String
    let message: String
}

extension AlertItem {
    static var noPermission: AlertItem {
        AlertItem(title: .noPermission,
                  message: .grantAccessToCamera)
    }

    static var invalidDeviceInput: AlertItem {
        AlertItem(title: .invalidDeviceInput,
                  message: .unableToCaptureInput)
    }

    static var invalidScannedValue: AlertItem {
        AlertItem(title: .invalidScanType,
                  message: .scannedValueIsNotValid)
    }

    static var notScannedYet: AlertItem {
        AlertItem(title: .notScannedYet,
                  message: .putCameraOnCode)
    }
}
