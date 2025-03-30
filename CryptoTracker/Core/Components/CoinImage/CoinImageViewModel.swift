//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 30/3/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coinModel: Coin
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coinModel: Coin) {
        self.coinModel = coinModel
        self.dataService = CoinImageService(coinModel: coinModel)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$image
        .sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { [weak self] returnedImage in
            self?.image = returnedImage
        }
        .store(in: &cancellables)
        
    }
}
