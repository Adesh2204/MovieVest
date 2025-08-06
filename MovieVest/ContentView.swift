//
//  ContentView.swift
//  MovieVest
//
//  Created by Adesh Shukla  on 18/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var trendingMovies: [MovieInvestment] = [
        MovieInvestment(title: "The Cosmic Front", platform: "Prime Video", tag: "Hot Pick", tagColor: .red),
        MovieInvestment(title: "Echoes of the Past", platform: "A24", tag: "Trending", tagColor: .green),
        MovieInvestment(title: "Neon City Nights", platform: "Netflix", tag: "Low Risk", tagColor: .blue)
    ]
    
    @State private var explorePressed = false
    @State private var howItWorksPressed = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Cyberpunk Hero Background
                CyberpunkHeroBackgroundView()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 48) {
                        // Header Section with Carousel
                        HStack(alignment: .center, spacing: 48) {
                            VStack(alignment: .leading, spacing: 20) {
                                // Main Title
                                Text("MovieVest")
                                    .font(.system(size: 70, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.black)
                                    .shadow(color: Color.purple.opacity(0.6), radius: 10, x: 0, y: 6)
                                    .padding(.bottom, 8)
                                // Summary
                                Text("Step into the future of film finance. MovieVest empowers you to invest in visionary films, connect with a passionate community, and experience the pulse of cinema's next wave.")
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.black)
                                    .padding(.bottom, 18)
                                    .lineSpacing(6)
                                    .shadow(color: Color.purple.opacity(0.25), radius: 4, x: 0, y: 2)
                                // Buttons with blue border effect
                                HStack(spacing: 24) {
                                    NavigationLink(destination: InvestingView()) {
                                        Text("Explore Releases")
                                            .font(.headline)
                                            .padding(.horizontal, 28)
                                            .padding(.vertical, 14)
                                            .background(
                                                LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .leading, endPoint: .trailing)
                                                    .clipShape(Capsule())
                                            )
                                            .foregroundColor(.black)
                                            .clipShape(Capsule())
                                            .shadow(color: Color.pink.opacity(0.4), radius: 10, x: 0, y: 4)
                                    }
                                    
                                    Button(action: {
                                        howItWorksPressed.toggle()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            howItWorksPressed = false
                                        }
                                    }) {
                                        Text("How It Works")
                                            .font(.headline)
                                            .padding(.horizontal, 28)
                                            .padding(.vertical, 14)
                                            .background(
                                                Color.black
                                                    .clipShape(Capsule())
                                                    .overlay(
                                                        Capsule()
                                                            .stroke(Color.purple, lineWidth: 2)
                                                    )
                                            )
                                            .foregroundColor(.white)
                                            .clipShape(Capsule())
                                            .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 4)
                                    }
                                }
                            }
                            // Image Carousel
                            MovieCarouselView()
                                .frame(width: 440, height: 320)
                                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                                .shadow(color: Color.purple.opacity(0.45), radius: 18, x: 0, y: 8)
                        }
                        .padding(40)
                        .frame(maxWidth: .infinity)
                        
                        // Trending Investments Section
                        VStack(spacing: 36) {
                            Text("Trending Investments")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                            HStack(spacing: 40) {
                                ForEach(trendingMovies) { movie in
                                    InvestmentCard(
                                        title: movie.title,
                                        tag: (movie.tag, movie.tagColor),
                                        platform: movie.platform
                                    )
                                    .frame(width: 320, height: 180)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(32)
                        .background(Color.white.opacity(0.13))
                        .cornerRadius(36)
                        .frame(maxWidth: .infinity)
                        
                        // Portfolio Section (Vertical, Full Width)
                        VStack(spacing: 48) {
                            PortfolioRow(
                                imageName: "CosmicFront",
                                title: "The Cosmic Front",
                                platform: "Prime Video",
                                investmentAmount: "₹10,000",
                                currentGain: "+₹2,000",
                                gainColor: .green,
                                summary: "A visually stunning sci-fi epic about humanity's journey to the edge of the universe, blending breathtaking visuals with a gripping story of hope and discovery.",
                                barData: [2000, 1000, -500, 1500, 2000, -1000, 500],
                                support: 0,
                                resistance: 2000,
                                barColor: .green
                            )
                            PortfolioRow(
                                imageName: "NeoncityLights",
                                title: "Neon City Lights",
                                platform: "Netflix",
                                investmentAmount: "₹15,000",
                                currentGain: "+₹4,000",
                                gainColor: .green,
                                summary: "A neon-drenched thriller set in a futuristic metropolis, where ambition and danger collide in a race for survival and fortune.",
                                barData: [1000, -500, 2000, 500, -1500, 2000, 1000],
                                support: -1500,
                                resistance: 2000,
                                barColor: .purple
                            )
                        }
                        .padding(32)
                        .background(Color.white.opacity(0.13))
                        .cornerRadius(36)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 40)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Investment Card
struct InvestmentCard: View {
    let title: String
    let tag: (String, Color)?
    let platform: String
    var body: some View {
        VStack(alignment: .center, spacing: 18) {
            HStack {
                if let tag = tag {
                    Text(tag.0)
                        .font(.title3.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(tag.1))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            Text(title)
                .font(.title2.bold())
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            Text(platform)
                .font(.title3)
                .foregroundColor(.black.opacity(0.7))
        }
        .padding(28)
        .background(Color.white.opacity(0.7))
        .cornerRadius(28)
        .shadow(color: Color.black.opacity(0.07), radius: 10, x: 0, y: 2)
    }
}

// MARK: - Portfolio Row (Card + Bar Graph)
struct PortfolioRow: View {
    let imageName: String
    let title: String
    let platform: String
    let investmentAmount: String
    let currentGain: String
    let gainColor: Color
    let summary: String
    let barData: [Double]
    let support: Double
    let resistance: Double
    let barColor: Color
    
    var body: some View {
        HStack(alignment: .top, spacing: 48) {
            ZStack {
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.18), Color.cyan.opacity(0.13)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .shadow(color: Color.purple.opacity(0.18), radius: 18, x: 0, y: 8)
                HStack(spacing: 36) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        .shadow(color: Color.purple.opacity(0.18), radius: 10, x: 0, y: 4)
                    VStack(alignment: .leading, spacing: 22) {
                        Text(title)
                            .font(.title.bold())
                            .foregroundColor(.black)
                        Text(platform)
                            .font(.title2)
                            .foregroundColor(.purple)
                        HStack {
                            Text("Investment Amount: ")
                                .font(.title2)
                                .foregroundColor(.black.opacity(0.7))
                            Text(investmentAmount)
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }
                        HStack(spacing: 14) {
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(gainColor)
                            Text(currentGain)
                                .font(.title2.bold())
                                .foregroundColor(gainColor)
                            Text("(Profit)")
                                .font(.title2)
                                .foregroundColor(gainColor.opacity(0.7))
                        }
                        Text(summary)
                            .font(.title3)
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.top, 10)
                    }
                    .padding(.vertical, 32)
                    .padding(.trailing, 24)
                }
                .padding(.leading, 24)
            }
            .frame(width: 650, height: 320)
            
            // Bar Graph
            BarGraphView(
                data: barData,
                support: support,
                resistance: resistance,
                barColor: barColor
            )
            .frame(width: 420, height: 320)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Bar Graph View
struct BarGraphView: View {
    let data: [Double]
    let support: Double
    let resistance: Double
    let barColor: Color
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let maxVal = max(resistance, data.max() ?? 1)
            let minVal = min(support, data.min() ?? 0)
            let barWidth = w / CGFloat(data.count * 2)
            let yScale = (maxVal - minVal) == 0 ? 1 : (h * 0.7) / CGFloat(maxVal - minVal)
            let baseY = h * 0.85
            
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white, barColor.opacity(0.08)]), startPoint: .top, endPoint: .bottom))
                    .shadow(color: barColor.opacity(0.10), radius: 10, x: 0, y: 4)
                
                // Bars
                HStack(alignment: .bottom, spacing: barWidth) {
                    ForEach(0..<data.count, id: \.self) { i in
                        let value = data[i]
                        let isProfit = value >= 0
                        RoundedRectangle(cornerRadius: 8)
                            .fill(isProfit ? Color.green : Color.red)
                            .frame(
                                width: barWidth,
                                height: abs(CGFloat(value) * yScale)
                            )
                            .overlay(
                                Text(String(format: "%.0f", value))
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .padding(.top, 2),
                                alignment: .top
                            )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: h * 0.7)
                .padding(.horizontal, barWidth)
                .padding(.top, h * 0.15)
                
                // Support line
                let supportY = baseY - CGFloat(support) * yScale
                Path { path in
                    path.move(to: CGPoint(x: 0, y: supportY))
                    path.addLine(to: CGPoint(x: w, y: supportY))
                }
                .stroke(Color.blue.opacity(0.7), style: StrokeStyle(lineWidth: 2, dash: [6, 4]))
                Text("SUPPORT")
                    .font(.title3.bold())
                    .foregroundColor(.blue)
                    .background(Color.white.opacity(0.7).cornerRadius(6))
                    .position(x: w * 0.18, y: supportY - 18)
                
                // Resistance line
                let resistanceY = baseY - CGFloat(resistance) * yScale
                Path { path in
                    path.move(to: CGPoint(x: 0, y: resistanceY))
                    path.addLine(to: CGPoint(x: w, y: resistanceY))
                }
                .stroke(Color.red.opacity(0.7), style: StrokeStyle(lineWidth: 2, dash: [6, 4]))
                Text("RESISTANCE")
                    .font(.title3.bold())
                    .foregroundColor(.red)
                    .background(Color.white.opacity(0.7).cornerRadius(6))
                    .position(x: w * 0.7, y: resistanceY + 18)
            }
        }
    }
}

// MARK: - Data Model
struct MovieInvestment: Identifiable {
    let id = UUID()
    let title: String
    let platform: String
    let tag: String
    let tagColor: Color
}

#Preview {
    ContentView()
}


