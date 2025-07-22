import SwiftUI
import Foundation

// MARK: - Shared Models for MovieVest App

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let platform: String
    let releaseDate: String
    let poster: String // Image asset name
    let tag: MovieTag?
    
    // Convenience initializer for ContentView compatibility
    init(title: String, platform: String, release: String, imageName: String, tag: String?) {
        self.title = title
        self.platform = platform
        self.releaseDate = release
        self.poster = imageName
        if let tagString = tag {
            switch tagString {
            case "Hot Pick":
                self.tag = .hotPick
            case "Trending":
                self.tag = .trending
            case "Low Risk":
                self.tag = .lowRisk
            default:
                self.tag = nil
            }
        } else {
            self.tag = nil
        }
    }
    
    // Primary initializer for Investing.swift compatibility
    init(title: String, platform: String, releaseDate: String, poster: String, tag: MovieTag?) {
        self.title = title
        self.platform = platform
        self.releaseDate = releaseDate
        self.poster = poster
        self.tag = tag
    }
}

enum MovieTag: String, CaseIterable {
    case hotPick = "🔥 Hot Pick"
    case lowRisk = "📉 Low Risk"
    case trending = "🎯 Trending"
    
    var color: Color {
        switch self {
        case .hotPick: return .pink
        case .lowRisk: return .teal
        case .trending: return .green
        }
    }
    
    var displayName: String {
        switch self {
        case .hotPick: return "Hot Pick"
        case .lowRisk: return "Low Risk"
        case .trending: return "Trending"
        }
    }
}

struct Investor: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
    let score: Int
}

struct Feature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
}

struct News: Identifiable {
    let id = UUID()
    let headline: String
}

struct Testimonial: Identifiable {
    let id = UUID()
    let feedback: String
    let user: String
}
