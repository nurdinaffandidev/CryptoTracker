//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by nurdin affandi on 30/3/25.
//

import Foundation
import SwiftUI
import Combine

@Observable
class CoinImageViewModel {
    var image: UIImage? = nil
    var isLoading: Bool = true
    
    private let coinModel: Coin
    private let service: APIServicing = APIService.shared
    private let fileManager: LocalFileManager = LocalFileManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(coinModel: Coin) {
        self.coinModel = coinModel
        self.getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(folderName: LocalFileManager.imageFolderName , imageName: coinModel.id) {
            image = savedImage
//            print("[📂] Retrieved image \(coinModel.name) from local file manager")
        } else {
            fetchCoinImage()
//            print("[📥] Downloading image \(coinModel.name) from server")
        }
    }
    
    private func fetchCoinImage() {
        guard let url = URL(string: coinModel.image) else { return }
        service.getCoinImage(from: url)
            .tryMap { (data) -> UIImage? in
                return UIImage(data: data)
            }
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                },
                receiveValue: { [weak self] returnedImage in
                    guard let self = self, let returnedImage else { return }
//                    print("[📸] Downloaded image \(coinModel.name)")
                    self.image = returnedImage
                    self.fileManager.saveImage(
                        image: returnedImage,
                        folderName: LocalFileManager.imageFolderName,
                        imageName: coinModel.id
                    )
            })
            .store(in: &cancellables)
    }
}
