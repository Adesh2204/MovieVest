import SwiftUI

struct MovieCarouselView: View {
    private let imageNames = [
        "CosmicFront",
        "Crimson",
        "Echosofthepast",
        "NeoncityLights",
        "StarlightSerenade",
        "WhispersoftheDead"
    ]
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .cornerRadius(32)
            TabView(selection: $currentIndex) {
                ForEach(0..<imageNames.count, id: \.self) { idx in
                    Image(imageNames[idx])
                        .resizable()
                        .scaledToFill()
                        .tag(idx)
                        .transition(.opacity.combined(with: .slide))
                        .animation(.easeInOut(duration: 0.7), value: currentIndex)
                }
            }
            .tabViewStyle(.automatic)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % imageNames.count
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .shadow(color: Color.purple.opacity(0.28), radius: 16, x: 0, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color.purple.opacity(0.6), lineWidth: 2)
            )
        }
    }
}
