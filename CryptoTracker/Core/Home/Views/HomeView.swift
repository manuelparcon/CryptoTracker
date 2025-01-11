//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Manuel Parcon on 11/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false // New sheet
    @State private var showSettingsView: Bool = false // New sheet
    @State private var animateSortChevron: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            // Content layer
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        } else {
                            portfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden) // For iOS 16+, navigation bar is automatically hidden if there is no navigation title
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background {
                    CircleButtonAnimationView(animate: $showPortfolio)
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        NavigationStack {
            List {
                ForEach(vm.allCoins) { coin in
                    NavigationLink(value: coin) {
                        CoinRowView(coin: coin, showHoldingsColumn: false)
                            .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                    }
                }
            }
            .navigationDestination(for: CoinModel.self, destination: { coin in
                DetailView(coin: coin)
            })
            .listStyle(PlainListStyle())
            .refreshable {
                vm.reloadData()
            }
        }
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioEmptyText: some View {
        Text("Click the + button to get started.")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                    // Same as code above
    //                if vm.sortOption == .rank {
    //                    vm.sortOption = .rankReversed
    //                } else {
    //                    vm.sortOption == .rank
    //                }
                }
            }
            HStack(spacing: 4) {
                Text("Holdings")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                    .animation(.default, value: animateSortChevron)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .opacity(showPortfolio ? 1.0 : 0.0)
            .animation(nil, value: showPortfolio)
            .accessibilityHidden(showPortfolio ? false : true)
            .onTapGesture {
                animateSortChevron.toggle()
                vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))

            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .frame(maxWidth: .infinity)
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
