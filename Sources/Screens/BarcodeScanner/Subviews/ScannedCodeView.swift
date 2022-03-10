//
//  ScannedCodeView.swift
//  BarcodeScanner
//
//  Created by Алексей Гурин on 10.03.2022.
//

import SwiftUI

struct ScannedCodeView: View {
    @ObservedObject
    var viewModel: BarcodeScannerViewModel

    var body: some View {
        HStack(spacing: .zero) {
            Text(viewModel.statusText.title)
                .foregroundColor(viewModel.statusTextColor)
                .font(.title2)
                .bold()
                .padding(.all, 5)
                .contextMenu(ContextMenu(menuItems: {
                    if viewModel.isSuccess {
                        Button(.from(.copy), action: {
                            UIPasteboard.general.string = viewModel.statusText.title
                        })
                    }
                }))
            if !viewModel.isSuccess {
                Menu(content: {
                    Text(viewModel.statusText.message)
                        .foregroundColor(viewModel.statusTextColor)
                        .font(.title2)
                        .bold()
                }, label: {
                    Image(systemSymbol: .infoCircle)
                        .foregroundColor(viewModel.statusTextColor)
                })
            }
        }

    }
}

struct ScannedCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedCodeView(viewModel: .init())
    }
}
