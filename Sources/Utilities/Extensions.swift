import Foundation
import SwiftUI

// MARK: - Localization extensions
enum Locale: String {
    case ru
    case en
}

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension View {
    func locale(_ id: Locale) -> some View {
        environment(\.locale, .init(identifier: id.rawValue))
    }
}

// MARK: - CodeType title
extension CodeType {
    var title: String {
        switch self {
            case .ean13:
                return "ean13"
            case .ean8:
                return "ean8"
            case .qr:
                return "QR"
            default:
                return "Unknown type"
        }
    }
}
