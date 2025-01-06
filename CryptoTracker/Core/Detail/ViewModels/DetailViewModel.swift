//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 1/6/25.
//

import Foundation
import Combine

class DetailViewModel:ObservableObject {
    
    private let coinDetailService: CoinDetailDataService // We will initialize coinDetailService in init so we can pass CoinModel so we can add coin
    private var cancellables = Set<AnyCancellable>()
    
    init (coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        
        coinDetailService.$coinDetails // Subscribe to coinDetails
            .sink { returnedCoinDetails in
                print("RECEIVED COIN DETAIL DATA")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
            
        
    }
}
