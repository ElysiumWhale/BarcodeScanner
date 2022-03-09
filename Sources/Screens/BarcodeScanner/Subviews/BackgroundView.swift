import SwiftUI

struct BackgroundView: View {
    let edge: Edge.Set

    var body: some View {
        Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 0.5).ignoresSafeArea(.all, edges: edge)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(edge: .bottom)
            .frame(width: .infinity, height: .infinity)
    }
}
