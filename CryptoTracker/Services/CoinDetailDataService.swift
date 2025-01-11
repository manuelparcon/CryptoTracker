//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 1/6/25.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
//    var cancellables = Set<AnyCancellable>()
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel // API's URL needs name of coin (specifically its id)
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        
        
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        // Download using combine
//        URLSession.shared.dataTaskPublisher(for: url)
        // Clean up code by creating a new file for generic code that we can reuse (NetworkingManager)
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder()) // Decode into a coin detail model
            .receive(on: DispatchQueue.main) // Receive on main thread
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
//            .store(in: &cancellables)
    }
}
