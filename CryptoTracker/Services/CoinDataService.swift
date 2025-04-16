//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 30/3/25.
//

import Foundation
import Combine

// TODO: remove unused class
class CoinDataService {
    @Published var allCoins: [Coin] = []
    var coinSubscriptions: AnyCancellable?
    
    init() {
        getAllCoins()
    }
    
    private func getAllCoins() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        guard let url = URL(string: urlString) else { return }
        coinSubscriptions = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscriptions?.cancel()
                }
            )
    }
    
}
