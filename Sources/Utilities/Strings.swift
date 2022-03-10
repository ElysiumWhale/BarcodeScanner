import SwiftUI

extension LocalizedStringKey {
    static func from(_ string: String) -> Self {
        Self(string)
    }
}

extension String {
    static let empty = ""
    static let ok = "Ok"
    static let no = "No"
    static let done = "Done"
    static let copy = "Copy"
    static let scanAgain = "Scan again"
    static let barcodeScanner = "Barcode scanner"
    static let scannedCode = "Scanned barcode:"
    static let putCameraOnCode = "Put your camera on code"
    static let invalidDeviceInput = "Invalid device input"
    static let unableToCaptureInput = "Unable to capture the input"
    static let invalidScanType = "Invalid scan type"
    static let notScannedYet = "Not scanned yet"
    static let scannedValueIsNotValid = "Scanned value is not valid. This app scans EAN-8 and EAN-13"
    static let noPermission = "App has no camera access"
    static let grantAccessToCamera = "Grant camera access for app to make scanning possible"
}
