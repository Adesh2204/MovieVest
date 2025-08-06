//
//  InvestingNeonCityLights.swift
//  MovieVest
//
//  Created by Adesh Shukla  on 24/07/25.
//

import Foundation
import SwiftUI

struct InvestNeonCityLightsView: View {
    var body: some View {
        ZStack {
            CyberpunkHeroBackgroundView()
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 48) {
                    // 1. Header Section
                    VStack(spacing: 8) {
                        Text("NeonCityLights")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundColor(Color.cyan)
                            .shadow(color: Color.purple.opacity(0.5), radius: 10, x: 0, y: 6)
                        Text("Netflix")
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)

                    // 2. Movie Information Section
                    VStack(spacing: 24) {
                        Text("In the pulsing heart of a neon-drenched metropolis, NeonCityLights weaves a mesmerizing tale of ambition and redemption, where every street corner tells a story and every light holds a secret.")
                            .font(.title2)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        Image("NeonCityLight")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 420, maxHeight: 320)
                            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                            .shadow(color: Color.cyan.opacity(0.25), radius: 18, x: 0, y: 8)
                    }
                    .frame(maxWidth: .infinity)

                    // 3. Cast & Crew Section
                    VStack(spacing: 18) {
                        Text("Cast & Crew")
                            .font(.title.bold())
                            .foregroundColor(.black)
                        HStack(alignment: .top, spacing: 48) {
                            VStack(spacing: 8) {
                                Image("Martin")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .shadow(radius: 8)
                                Text("Martin Scorsese")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Director")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.7))
                            }
                            VStack(spacing: 8) {
                                Image("Chris1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .shadow(radius: 8)
                                Text("Chris Evans")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Cast")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.7))
                            }
                            VStack(spacing: 8) {
                                Image("Emma")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .shadow(radius: 8)
                                Text("Emma Watson")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Text("Cast")
                                    .font(.caption)
                                    .foregroundColor(.black.opacity(0.7))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)

                    // 4. Investment Analysis Section
                    VStack(spacing: 18) {
                        Text("WHY SHOULD ONE INVEST IN NEON CITY LIGHTS")
                            .font(.title.bold())
                            .foregroundColor(.black)
                        Text("NeonCityLights is capturing the market's imagination with its unique blend of visual storytelling and star power. The film's buzz is driving investor interest, with early backers seeing strong momentum as anticipation builds for its global release. The urban sci-fi genre is trending, and NeonCityLights is poised to be a breakout hit for both audiences and investors.")
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)

                    // 5. Trading Chart Section
                    VStack(spacing: 18) {
                        Text("Trading Chart")
                            .font(.title.bold())
                            .foregroundColor(.black)
                        NeonCityCandlestickChartView()
                            .frame(height: 320)
                            .background(Color.white.opacity(0.13))
                            .cornerRadius(28)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity)

                    // 6. Investment Call-to-Action
                    VStack(spacing: 18) {
                        Text("Investment Starts with only 1 token Rs 1756 + G.S.T")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                        Button(action: {}) {
                            Text("Invest Now")
                                .font(.title.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 60)
                                .padding(.vertical, 22)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                .clipShape(Capsule())
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 40)
                }
                .padding(.vertical, 32)
                .padding(.horizontal, 0)
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Neon City Candlestick Chart View (Distinct from CosmicFront)
struct NeonCityCandlestickChartView: View {
    // Example data for 10 periods (distinct from CosmicFront)
    let prices: [(open: Double, close: Double, high: Double, low: Double, volume: Double, profit: Bool)] = [
        (80, 100, 110, 75, 1800, true),
        (100, 90, 115, 85, 1600, false),
        (90, 120, 125, 88, 2200, true),
        (120, 115, 130, 110, 2100, false),
        (115, 140, 145, 110, 2700, true),
        (140, 135, 150, 130, 1900, false),
        (135, 160, 165, 130, 3000, true),
        (160, 155, 170, 150, 1700, false),
        (155, 180, 185, 150, 3200, true),
        (180, 175, 190, 170, 2100, false)
    ]
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let maxPrice = prices.map { $0.high }.max() ?? 1
            let minPrice = prices.map { $0.low }.min() ?? 0
            let priceRange = maxPrice - minPrice
            let barWidth = w / CGFloat(prices.count * 2)
            let maxVolume = prices.map { $0.volume }.max() ?? 1
            ZStack {
                // Grid lines
                ForEach(0..<6) { i in
                    let y = h * 0.1 + CGFloat(i) * h * 0.7 / 5
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: w, y: y))
                    }
                    .stroke(Color.purple.opacity(0.18), lineWidth: 1)
                    let priceLabel = maxPrice - Double(i) * priceRange / 5
                    Text(String(format: "%.0f", priceLabel))
                        .font(.caption2)
                        .foregroundColor(.black)
                        .position(x: 32, y: y - 10)
                }
                // Candlesticks
                HStack(alignment: .bottom, spacing: barWidth) {
                    ForEach(0..<prices.count, id: \ .self) { i in
                        let p = prices[i]
                        let openY = h * 0.1 + CGFloat((maxPrice - p.open) / priceRange) * h * 0.7
                        let closeY = h * 0.1 + CGFloat((maxPrice - p.close) / priceRange) * h * 0.7
                        let highY = h * 0.1 + CGFloat((maxPrice - p.high) / priceRange) * h * 0.7
                        let lowY = h * 0.1 + CGFloat((maxPrice - p.low) / priceRange) * h * 0.7
                        let isProfit = p.profit
                        VStack {
                            ZStack {
                                // Wick
                                Path { path in
                                    path.move(to: CGPoint(x: barWidth / 2, y: highY))
                                    path.addLine(to: CGPoint(x: barWidth / 2, y: lowY))
                                }
                                .stroke(isProfit ? Color.green : Color.red, lineWidth: 2)
                                // Body
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(isProfit ? Color.green : Color.red)
                                    .frame(width: barWidth, height: abs(closeY - openY))
                                    .offset(y: min(openY, closeY) - highY)
                            }
                            // Volume bar
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.cyan.opacity(0.4))
                                .frame(width: barWidth, height: CGFloat(p.volume / maxVolume) * h * 0.18)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: h * 0.8, alignment: .bottom)
                .padding(.horizontal, barWidth)
                // Profit/Loss indicators
                ForEach(0..<prices.count, id: \ .self) { i in
                    let p = prices[i]
                    let closeY = h * 0.1 + CGFloat((maxPrice - p.close) / priceRange) * h * 0.7
                    Image(systemName: p.profit ? "arrow.up.right" : "arrow.down.right")
                        .foregroundColor(p.profit ? .green : .red)
                        .position(x: CGFloat(i) * (w / CGFloat(prices.count)) + barWidth, y: closeY - 18)
                }
            }
        }
    }
}

struct InvestNeonCityLightsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestNeonCityLightsView()
    }
}
