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
