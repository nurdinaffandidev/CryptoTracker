//
//  APIServicing.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 16/4/25.
//

import Foundation
import Combine

public protocol APIServicing {
    func getAllCoins() -> AnyPublisher<Data, Error>
}
