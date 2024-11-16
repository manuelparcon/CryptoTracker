//
//  CoinDataServices.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/14/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = [] // Using @Published makes allCoins a publisher that can have subscribers
//    var cancellables = Set<AnyCancellable>()
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        // Download using combine
//        URLSession.shared.dataTaskPublisher(for: url)
        // Clean up code by creating a new file for generic code that we can reuse (NetworkingManager)
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder()) // Decode into coin models
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
//            .store(in: &cancellables)

    }
}
