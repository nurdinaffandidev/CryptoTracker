//
//  APIService.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 16/4/25.
//

import Foundation
import Combine

class APIService: APIServicing {
    public static let shared = APIService()
    private init() {}
    
    public func getAllCoins() -> AnyPublisher<Data, Error> {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return NetworkingManager.download(url: url)
    }
    
    public func getCoinImage(from url: URL) -> AnyPublisher<Data, Error> {
        return NetworkingManager.download(url: url)
    }
}
