//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 1/6/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @State private var progress: Double = 0.0
        
    let coinData: [Double]
    var data: [PriceOverTime] = []
    
    let yValues: [Double]
    let minY: Double
    let maxY: Double
    
    let startingDate: Date
    let endingDate: Date
    
    let lineColor: Color
    
    init(coin: CoinModel) {
        coinData = coin.sparklineIn7D?.price ?? []
        
        // Generate PriceOverTime array
        var tempData: [PriceOverTime] = []
        for (index, price) in coinData.enumerated() {
            tempData.append(PriceOverTime(price: price, date: index))
        }
        data = tempData
        
        // For scaling y-axis
        yValues = data.map { $0.price }
        minY = yValues.min() ?? 0
        maxY = yValues.max() ?? 0
        
        let priceChange = (coinData.last ?? 0) - (coinData.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        // For manually added x-axis labels
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
            chartDataLabels
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    
    private var chartView: some View {
        Chart(data) {
            LineMark(
                x: .value("Date", $0.date),
                y: .value("Price", $0.price)
            )
            .foregroundStyle(lineColor)
        }
        .chartXAxis(.hidden)
        .chartYScale(domain: minY...maxY)
    }
    
    // Manually added x-axis labels
    private var chartDataLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }

    }
}
