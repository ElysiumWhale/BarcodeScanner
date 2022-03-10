import SwiftUI

// MARK: - List viewModel
final class CodeElementsListViewModel: ObservableObject {
    static let availableCodeTypes: [CodeElementViewModel] = [
        .init(type: .ean8),
        .init(type: .ean13),
        .init(type: .qr)
    ]

    var availableCodeTypes: [CodeElementViewModel] {
        CodeElementsListViewModel.availableCodeTypes
    }

    @Published
    var selectedCodeTypes: [CodeElementViewModel] = {
        guard let codes: [String] = Defaults.get(for: .selectedCodeTypes) else {
            return []
        }

        let persisted = availableCodeTypes.filter { codes.contains($0.type.rawValue) }
        persisted.forEach { $0.isSelected = true }
        return persisted
    }()

    func select(_ type: CodeElementViewModel) {
        if let index = selectedCodeTypes.firstIndex(where: { $0 === type }) {
            type.isSelected = false
            selectedCodeTypes.remove(at: index)
        } else {
            type.isSelected = true
            selectedCodeTypes.append(type)
        }

        persistSelected()
    }

    private func persistSelected() {
        Defaults.set(value: selectedCodeTypes.map { $0.type.rawValue },
                     for: .selectedCodeTypes)
    }
}

// MARK: - List element viewModel
final class CodeElementViewModel: ObservableObject, Identifiable {
    let type: CodeType

    @Published
    var isSelected = false

    var title: String {
        type.title
    }

    init(type: CodeType, isSelected: Bool = false) {
        self.type = type
        self.isSelected = isSelected
    }
}
