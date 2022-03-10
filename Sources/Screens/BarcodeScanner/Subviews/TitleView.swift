import SwiftUI

struct TitleView: View {
    @ObservedObject
    var viewModel: CodeElementsListViewModel

    var body: some View {
        HStack {
            Text(.from(.barcodeScanner))
                .font(.title)
                .foregroundColor(.white)
                .padding()

            Menu(content: {
                ForEach(viewModel.availableCodeTypes) { type in
                    CodeTypeView(viewModel: type) { [weak type] in
                        performSelection(for: type)
                    }
                }
            }, label: {
                Label(.from(.empty), systemSymbol: .gear)
                    .foregroundColor(.white)
            })
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .background(BackgroundView(edge: .top))
    }

    private func performSelection(for type: CodeElementViewModel?) {
        guard let type = type else {
            return
        }

        viewModel.select(type)
    }
}

struct CodeTypeView: View {
    @ObservedObject
    var viewModel: CodeElementViewModel

    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Label(title: {
                Text(viewModel.title)
            }, icon: {
                if viewModel.isSelected {
                    Image(systemSymbol: .checkmark)
                }
            })
        })
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(viewModel: .init())
    }
}
