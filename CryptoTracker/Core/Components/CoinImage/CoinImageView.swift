//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 30/3/25.
//

import SwiftUI

struct CoinImageView: View {
    @State var viewModel: CoinImageViewModel
    
    init(coinModel: Coin) {
        _viewModel = State(wrappedValue: .init(coinModel: coinModel))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageView(coinModel: DeveloperPreview.shared.coin)
}
