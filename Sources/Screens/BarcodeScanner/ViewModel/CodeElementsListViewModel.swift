import SwiftUI

// MARK: - List viewModel
final class CodeElementsListViewModel: ObservableObject {
    let availableCodeTypes: [CodeElementViewModel] = [
        .init(type: .ean8),
        .init(type: .ean13),
        .init(type: .qr),
        .init(type: .face)
    ]

    @Published
    var selectedCodeTypes: [CodeElementViewModel] = []

    func select(_ type: CodeElementViewModel) {
        if let index = selectedCodeTypes.firstIndex(where: { $0 === type }) {
            type.isSelected = false
            selectedCodeTypes.remove(at: index)
        } else {
            type.isSelected = true
            selectedCodeTypes.append(type)
        }
    }
}

// MARK: - List element viewModel
final class CodeElementViewModel: ObservableObject, Identifiable {
    let type: CodeType

    @Published
    var isSelected = false

    var title: String {
        type.rawValue
    }

    init(type: CodeType, isSelected: Bool = false) {
        self.type = type
        self.isSelected = isSelected
    }
}

