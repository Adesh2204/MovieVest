import SwiftUI

struct AnimatedBackgroundView: View {
    @State private var time: Double = 0
    let timer = Timer.publish(every: 1.0/60.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                // Base dark gradient
                let gradient = Gradient(colors: [
                    Color(.windowBackgroundColor),
                    Color(.controlBackgroundColor).opacity(0.7),
                    Color.black.opacity(0.9)
                ])
                let rect = CGRect(origin: .zero, size: size)
                let bgPath = Path(rect)
let bgFill = GraphicsContext.Shading.linearGradient(
    gradient,
    startPoint: CGPoint(x: 0, y: 0),
    endPoint: CGPoint(x: size.width, y: size.height)
)
context.fill(bgPath, with: bgFill)
                
                // Animated abstract shapes (placeholder: moving ellipse)
                let t = time
                let center1 = CGPoint(
                    x: size.width * 0.3 + sin(t * 0.2) * 40,
                    y: size.height * 0.4 + cos(t * 0.18) * 35
                )
                let ellipse1 = CGRect(
                    x: center1.x - 120,
                    y: center1.y - 60,
                    width: 240,
                    height: 120
                )
                context.fill(
                    Path(ellipseIn: ellipse1),
                    with: .radialGradient(
                        .init(colors: [Color(.controlBackgroundColor).opacity(0.18), Color.clear]),
                        center: .init(x: 0.5, y: 0.5),
                        startRadius: 10,
                        endRadius: 120
                    )
                )
                
                // Animated particles (placeholder: slow glowing dots)
                for i in 0..<8 {
                    let angle = t * 0.08 + Double(i) * .pi / 4
                    let radius = 110 + sin(t * 0.13 + Double(i)) * 18
                    let x = size.width * 0.5 + cos(angle) * radius
                    let y = size.height * 0.5 + sin(angle) * radius
                    let particleRect = CGRect(x: x - 6, y: y - 6, width: 12, height: 12)
                    context.fill(
                        Path(ellipseIn: particleRect),
                        with: .radialGradient(
                            .init(colors: [Color.white.opacity(0.07), Color.clear]),
                            center: .init(x: 0.5, y: 0.5),
                            startRadius: 2,
                            endRadius: 12
                        )
                    )
                }
            }
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                time += 1.0 / 60.0
            }
        }
    }
}

#Preview {
    AnimatedBackgroundView()
}
