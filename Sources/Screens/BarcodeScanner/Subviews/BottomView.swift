import SwiftUI

struct BottomView: View {
    @ObservedObject
    var viewModel: BarcodeScannerViewModel

    var body: some View {
        VStack {
            Label(.from(.scannedCode), systemSymbol: .barcodeViewfinder)
                .font(.title2)
                .foregroundColor(.white)

            ScannedCodeView(viewModel: viewModel)

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
            .locale(.ru)
    }
}
