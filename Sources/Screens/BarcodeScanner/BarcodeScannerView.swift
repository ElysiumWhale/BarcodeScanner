import SwiftUI

struct BarcodeScannerView: View {
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        ZStack {
            ScannerView(result: $viewModel.result, isScanning: $viewModel.isScanning)
                .ignoresSafeArea()
            VStack {
                TitleView()
                Spacer()
                VStack {
                    Label("Scanned barcode:", systemImage: "barcode.viewfinder")
                        .font(.title)
                        .foregroundColor(.white)
                    Text(viewModel.statusText)
                        .foregroundColor(viewModel.statusTextColor)
                        .font(.title)
                        .bold()
                        .padding(.all, 5)
                        .contextMenu(ContextMenu(menuItems: {
                            Button(Strings.copy.localized, action: { UIPasteboard.general.string = viewModel.statusText })
                        }))
                    Button(Strings.scanAgain.localized) {
                        viewModel.isScanning = true
                        viewModel.result = .failure(.notScannedYet())
                    }
                    .frame(width: 150, height: 50)
                    .background(Color.blue.opacity(viewModel.isScanning ? 0.3 : 1))
                    .cornerRadius(15)
                    .font(.title2)
                    .foregroundColor(.white.opacity(viewModel.isScanning ? 0.3 : 1))
                    .disabled(viewModel.isScanning)
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                .padding()
                .background(Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 0.5).ignoresSafeArea(.all, edges: .bottom))
            }
        }
    }
}

struct TitleView: View {
    var body: some View {
        Text(Strings.barcodeScanner.localized)
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 0.5).ignoresSafeArea(.all, edges: .top))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
