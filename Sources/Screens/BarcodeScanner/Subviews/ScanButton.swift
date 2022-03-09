import SwiftUI

struct ScanButton: View {
    let action: () -> Void

    var isScanning: Bool = false

    var body: some View {
        Button(.from(.scanAgain), action: action)
            .frame(idealWidth: 150, maxWidth: .infinity, minHeight: 50)
            .background(Color.blue.opacity(isScanning ? 0.3 : 1))
            .cornerRadius(15)
            .font(.title2)
            .foregroundColor(.white.opacity(isScanning ? 0.3 : 1))
            .disabled(isScanning)
    }
}
