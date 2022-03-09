import SwiftUI

struct BottomView: View {
    @ObservedObject
    var viewModel: BarcodeScannerViewModel

    var body: some View {
        VStack {
            Label(.from(.scannedCode), systemSymbol: .barcodeViewfinder)
                .font(.title)
                .foregroundColor(.white)

            Text(viewModel.statusText)
                .foregroundColor(viewModel.statusTextColor)
                .font(.title)
                .bold()
                .padding(.all, 5)
                .contextMenu(ContextMenu(menuItems: {
                    Button(.from(.copy), action: {
                        UIPasteboard.general.string = viewModel.statusText
                    })
                }))

            ScanButton(action: viewModel.scanAgain,
                       isScanning: viewModel.isScanning)
        }
        .frame(maxWidth: .infinity, alignment: .bottom)
        .padding()
        .background(BackgroundView(edge: .bottom))
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView(viewModel: .init())
    }
}
