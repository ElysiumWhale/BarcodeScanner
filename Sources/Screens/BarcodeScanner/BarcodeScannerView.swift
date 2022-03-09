import SwiftUI
import SFSafeSymbols

struct BarcodeScannerView: View {
    @StateObject
    var viewModel = BarcodeScannerViewModel()

    var body: some View {
        ZStack {
            ScannerView(result: $viewModel.result,
                        isScanning: $viewModel.isScanning)
                .ignoresSafeArea()
            VStack {
                TitleView()
                Spacer()
                BottomView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
