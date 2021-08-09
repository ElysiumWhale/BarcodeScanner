import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

extension AlertItem {
    static let invalidDeviceInput = AlertItem(title: "Invalid device input", message: "Unable to capture the input", dismissButton: .default(Text("Ok")))
    
    static let invalidScannedValue = AlertItem(title: "Invalid scan type", message: "Scanned value is not valid. This app scans EAN-8 and EAN-13", dismissButton: .default(Text("Ok")))
    
    static let notScannedYet = AlertItem(title: "Not scanned yet", message: "Put your camera on code", dismissButton: .default(Text("Ok")))
}
