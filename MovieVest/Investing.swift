import SwiftUI
import Foundation

// MARK: - Models
struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let platform: String
    let releaseDate: String
    let poster: String // Image asset name
    let tag: MovieTag?
}

enum MovieTag: String {
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
}

// MARK: - ViewModel
class InvestingViewModel: ObservableObject {
    @Published var selectedPlatform: String = "All Platforms"
    @Published var searchText: String = ""
    @Published var currentPage: Int = 1
    let platforms = ["All Platforms", "Netflix", "Prime Video", "Hulu", "Paramount+", "HBO Max", "A24"]
    let moviesPerPage = 6
    @Published var movies: [Movie] = [
        Movie(title: "The Cosmic Front", platform: "Prime Video", releaseDate: "Dec 2024", poster: "cosmic", tag: .hotPick),
        Movie(title: "Echoes of the Past", platform: "A24", releaseDate: "Jan 2025", poster: "echoes", tag: .trending),
        Movie(title: "Neon City Nights", platform: "Netflix", releaseDate: "Nov 2024", poster: "neoncity", tag: .lowRisk),
        Movie(title: "Whispers of the Dead", platform: "HBO Max", releaseDate: "Feb 2025", poster: "whispers", tag: nil),
        Movie(title: "Starlight Serenade", platform: "Hulu", releaseDate: "Mar 2025", poster: "starlight", tag: nil),
        Movie(title: "Crimson", platform: "Paramount+", releaseDate: "Apr 2025", poster: "crimson", tag: nil)
    ]
    var filteredMovies: [Movie] {
        let filtered = movies.filter { (selectedPlatform == "All Platforms" || $0.platform == selectedPlatform) && (searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)) }
        return filtered
    }
    var pagedMovies: [Movie] {
        let start = (currentPage - 1) * moviesPerPage
        let end = min(start + moviesPerPage, filteredMovies.count)
        return Array(filteredMovies[start..<end])
    }
    var totalPages: Int {
        max(1, Int(ceil(Double(filteredMovies.count) / Double(moviesPerPage))))
    }
}

// MARK: - Main Investing View
struct InvestingView: View {
    @StateObject private var vm = InvestingViewModel()
    @Namespace private var animation
    var body: some View {
        ZStack {
            AnimatedBackground()
            VStack(spacing: 0) {
                HeaderView()
                Divider().opacity(0.2)
                mainSection
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
        .frame(minWidth: 1100, minHeight: 800)
    }
    var mainSection: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Invest in Upcoming Releases")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
            Text("Explore and invest in the next big hits from the world of cinema and streaming.")
                .font(.title3)
                .foregroundStyle(.white.opacity(0.8))
            HStack(spacing: 16) {
                Picker("Platform", selection: $vm.selectedPlatform) {
                    ForEach(vm.platforms, id: \ .self) { Text($0) }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 180)
                TextField("Search movies...", text: $vm.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 260)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 28) {
                    ForEach(vm.pagedMovies) { movie in
                        MovieCardView(movie: movie, animation: animation)
                    }
                }
                .padding(.vertical, 8)
            }
            pagination
        }
        .padding(.top, 32)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: .black.opacity(0.18), radius: 32, x: 0, y: 16)
        .padding(.vertical, 32)
    }
    var pagination: some View {
        HStack(spacing: 12) {
            ForEach(1...vm.totalPages, id: \ .self) { page in
                Button(action: { vm.currentPage = page }) {
                    Text("\(page)")
                        .fontWeight(.semibold)
                        .frame(width: 36, height: 36)
                        .background(vm.currentPage == page ? Color.cyan.opacity(0.8) : Color.white.opacity(0.12))
                        .foregroundStyle(vm.currentPage == page ? .white : .white.opacity(0.7))
                        .clipShape(Circle())
                        .shadow(color: vm.currentPage == page ? .cyan.opacity(0.3) : .clear, radius: 8, x: 0, y: 2)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.top, 8)
    }
}

// MARK: - Header
struct HeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                Image(systemName: "film.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.cyan)
                Text("MovieVest")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            Spacer()
            HStack(spacing: 32) {
                ForEach(["Home", "Invest", "Portfolio", "News"], id: \ .self) { nav in
                    Text(nav)
                        .font(.title3)
                        .fontWeight(nav == "Invest" ? .bold : .regular)
                        .foregroundStyle(nav == "Invest" ? .cyan : .white.opacity(0.8))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(nav == "Invest" ? Color.cyan.opacity(0.12) : .clear)
                        .clipShape(Capsule())
                }
            }
            Spacer()
            HStack(spacing: 18) {
                Button(action: {}) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.85))
                }
                .buttonStyle(PlainButtonStyle())
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 38, height: 38)
                    .overlay(
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.white)
                    )
            }
        }
        .padding(.vertical, 12)
    }
}

// MARK: - Movie Card
struct MovieCardView: View {
    let movie: Movie
    var animation: Namespace.ID
    @State private var isHovering = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topLeading) {
                Group {
                    if movie.title == "The Cosmic Front" {
                        Image("CosmicFront")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .clipped()
                    } else if movie.title == "Crimson" {
                        Image("Crimson")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .clipped()
                    } else if movie.title == "Echoes of the Past" {
                        Image("Echosofthepast")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .clipped()
                    } else if movie.title == "Neon City Nights" {
                        Image("NeoncityLights")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .clipped()
                    } else if movie.title == "Starlight Serenade" {
                        Image("StarlightSerenade")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .clipped()
                    } else if movie.title == "Whispers of the Dead" {
                        Image("WhispersoftheDead")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .clipped()
                    }
                }
                Image(movie.poster)
                    .resizable()
                    .aspectRatio(0.7, contentMode: .fill)
                    .frame(width: 170, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .shadow(color: .black.opacity(0.22), radius: 16, x: 0, y: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(isHovering ? Color.cyan.opacity(0.7) : Color.clear, lineWidth: 3)
                            .animation(.easeInOut(duration: 0.25), value: isHovering)
                    )
                if let tag = movie.tag {
                    Text(tag.rawValue)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(tag.color.opacity(0.92))
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding(10)
                        .shadow(radius: 6)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            Text(movie.title)
                .font(.headline)
                .foregroundStyle(.white)
                .lineLimit(2)
            Text(movie.platform)
                .font(.subheadline)
                .foregroundStyle(.cyan)
            Text(movie.releaseDate)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
            Spacer(minLength: 0)
            Button(action: {}) {
                Text("Invest")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.purple]), startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .shadow(color: .cyan.opacity(0.25), radius: 8, x: 0, y: 4)
                    .scaleEffect(isHovering ? 1.05 : 1.0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isHovering)
            }
            .buttonStyle(PlainButtonStyle())
            .onHover { hovering in
                withAnimation { isHovering = hovering }
            }
        }
        .padding(18)
        .frame(width: 200, height: 390)
        .background(
            BlurView(style: .underWindowBackground)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(isHovering ? Color.cyan.opacity(0.4) : Color.white.opacity(0.08), lineWidth: 1.5)
        )
        .shadow(color: .black.opacity(0.22), radius: 18, x: 0, y: 10)
        .onHover { hovering in
            withAnimation { isHovering = hovering }
        }
    }
}

// MARK: - Animated Background
struct AnimatedBackground: View {
    @State private var animate = false
    var body: some View {
        ZStack {
            // Futuristic neon-lit cityscape background
            CyberpunkCityscape()
            // Animated fog layer
            AnimatedFog()
            // Floating particles (stars, sparks)
            ParticleField()
            // Neon light flares
            LightFlares()
            // Subtle film reel texture overlay
            FilmReelTexture()
        }
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: animate)
        .onAppear { animate = true }
    }
}

// MARK: - Cyberpunk Cityscape
struct CyberpunkCityscape: View {
    @State private var offset: CGFloat = 0
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    let t = timeline.date.timeIntervalSinceReferenceDate
                    // Animate building lights
                    for i in 0..<18 {
                        let baseX: CGFloat = CGFloat(i) * size.width / 18
                        let wave: CGFloat = CGFloat(sin(t * 0.3 + Double(i))) * 8
                        let buildingX = baseX + wave
                        let randomHeightFactor: CGFloat = CGFloat(0.25 + (Double(i % 7) * 0.07)) // deterministic pseudo-random
                        let buildingHeight: CGFloat = randomHeightFactor * size.height
                        let buildingWidth: CGFloat = size.width / 22
                        let buildingRect = CGRect(x: buildingX, y: size.height - buildingHeight, width: buildingWidth, height: buildingHeight)
                        let neonColor = Color(hue: Double(i) / 18.0, saturation: 0.9, brightness: 1.0).opacity(0.85)
                        context.fill(RoundedRectangle(cornerRadius: 6).path(in: buildingRect), with: .color(neonColor))
                        // Neon sign
                        if i % 3 == 0 {
                            let signRect = CGRect(x: buildingX + 6, y: size.height - buildingHeight - 18, width: 32, height: 10)
                            let signColor = Color.cyan.opacity(0.7 + 0.3 * sin(t * 1.2 + Double(i)))
                            context.fill(RoundedRectangle(cornerRadius: 4).path(in: signRect), with: .color(signColor))
                        }
                    }
                }
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Animated Fog
struct AnimatedFog: View {
    @State private var fogOffset: CGFloat = 0
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { timeline in
                let t = timeline.date.timeIntervalSinceReferenceDate
                let offset = CGFloat(sin(t * 0.12)) * 80
                ZStack {
                    ForEach(0..<2) { i in
                        LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.10), Color.clear]), startPoint: .leading, endPoint: .trailing)
                            .frame(width: geo.size.width * 1.2, height: 120)
                            .blur(radius: 32)
                            .offset(x: offset + CGFloat(i) * 120, y: geo.size.height * 0.6 + CGFloat(i) * 40)
                            .opacity(0.5 - 0.2 * Double(i))
                    }
                }
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - ParticleField
struct ParticleField: View {
    @State private var particles: [CGPoint] = (0..<32).map { _ in CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1)) }
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    for i in 0..<particles.count {
                        let t = CGFloat(timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(dividingBy: 10))
                        let x = (particles[i].x + 0.03 * Foundation.sin(t + CGFloat(i))) .truncatingRemainder(dividingBy: 1)
                        let y = (particles[i].y + 0.02 * Foundation.cos(t + CGFloat(i))) .truncatingRemainder(dividingBy: 1)
                        let pos = CGPoint(x: x * size.width, y: y * size.height)
                        let color = Color.white.opacity(0.11 + 0.09 * Foundation.sin(t + CGFloat(i)))
                        context.fill(Ellipse().path(in: CGRect(x: pos.x, y: pos.y, width: 18, height: 18)), with: .color(color))
                    }
                }
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Light Flares
struct LightFlares: View {
    @State private var flarePos: CGFloat = 0.2
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.18), Color.clear]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 320, height: 120)
                        .offset(x: CGFloat(i) * 220 - 120, y: CGFloat(i) * 80 + 80)
                        .blur(radius: 32)
                        .opacity(0.7)
                        .animation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true), value: flarePos)
                }
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - Film Reel Texture
struct FilmReelTexture: View {
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                for i in stride(from: 0, to: size.width, by: 60) {
                    let rect = CGRect(x: i, y: 0, width: 36, height: size.height)
                    context.fill(RoundedRectangle(cornerRadius: 18).path(in: rect), with: .color(Color.white.opacity(0.03)))
                }
            }
        }
        .allowsHitTesting(false)
    }
}

// MARK: - BlurView Helper
struct BlurView: NSViewRepresentable {
    let style: NSVisualEffectView.Material
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.material = style
        view.blendingMode = .withinWindow
        view.state = .active
        return view
    }
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}

// MARK: - Preview
struct InvestingView_Previews: PreviewProvider {
    static var previews: some View {
        InvestingView()
            .preferredColorScheme(.dark)
            .frame(width: 1400, height: 900)
    }
}


