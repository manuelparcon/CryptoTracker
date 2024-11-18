//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/13/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin:  CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            centerColumn
            rightColumn
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack() {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 10, alignment: .leading)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var centerColumn: some View {
        VStack {
            if showHoldingsColumn {
                VStack(alignment: .trailing) {
                    Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                        .bold()
                    Text((coin.currentHoldings ?? 0).asNumberString())
                }
                .font(.body)
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .font(.body)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
