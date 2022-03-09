import SwiftUI

struct TitleView: View {
    var body: some View {
        Text(.from(.barcodeScanner))
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .top)
            .background(BackgroundView(edge: .top))
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
