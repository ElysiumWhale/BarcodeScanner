import Foundation

public enum Strings: String, Localizable {
    case ok = "Ok"
    case no = "No"
    case done = "Done"
    case copy = "Copy"
    case scanAgain = "Scan again"
    case barcodeScanner = "Barcode scanner"
    
    var localized: String { rawValue.localized }
}
