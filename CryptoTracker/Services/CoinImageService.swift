//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 30/3/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage?
    private var imageSubscription: AnyCancellable?
    private let coinModel: Coin
    
    init (coinModel: Coin) {
        self.coinModel = coinModel
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coinModel.image) else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
    }
    
}
