//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 12/6/24.
//

import SwiftUI

//struct DetailLoadingView: View {
//    
//    @Binding var coin: CoinModel?
//    
//    var body: some View {
//        ZStack {
//            if let coin = coin {
//                DetailView(coin: coin)
//            }
//        }
//    }
//}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel // Initialize vm in init since DataViewModel needs coin
        
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
