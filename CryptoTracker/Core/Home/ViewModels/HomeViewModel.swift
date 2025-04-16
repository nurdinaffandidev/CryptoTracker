//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 27/3/25.
//

import Foundation
import Combine

@Observable
class HomeViewModel {
    var allCoins: [Coin] = []
    var portfolioCoins: [Coin] = []
    var showAlert: Bool = false
    
    private let service: APIServicing = APIService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchAllCoins()
    }
    
    func fetchAllCoins() {
        service.getAllCoins()
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
    }
}
