import SwiftUI

struct CyberpunkHeroBackgroundView: View {
    @State private var time: Double = 0
    let timer = Timer.publish(every: 1.0/60.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                let t = time
                drawNeonBackground(context: context, size: size)
                drawBuildings(context: context, size: size, t: t)
                drawHaze(context: context, size: size)
                drawParticles(context: context, size: size, t: t)
                drawStreaks(context: context, size: size, t: t)
                drawFlicker(context: context, size: size, t: t)
            }
            .ignoresSafeArea()
            .onReceive(timer) { _ in
                time += 1.0 / 60.0
            }
        }
    }

    private func drawNeonBackground(context: GraphicsContext, size: CGSize) {
        let neonGradient = Gradient(colors: [
            Color(red: 0.2, green: 0.0, blue: 0.6),
            Color(red: 0.0, green: 1.0, blue: 1.0),
            Color(red: 1.0, green: 0.0, blue: 0.7),
            Color(red: 0.0, green: 0.7, blue: 1.0),
            Color(red: 0.3, green: 0.0, blue: 0.4)
        ])
        let bgRect = CGRect(origin: .zero, size: size)
        context.fill(
            Path(bgRect),
            with: .linearGradient(
                neonGradient,
                startPoint: CGPoint(x: 0, y: size.height * 0.2),
                endPoint: CGPoint(x: size.width, y: size.height * 0.8)
            )
        )
    }

    private func drawBuildings(context: GraphicsContext, size: CGSize, t: Double) {
        for i in 0..<6 {
            let phase = t * 0.12 + Double(i) * 0.9
            let x = size.width * (0.13 + 0.13 * Double(i)) + sin(phase) * 10
            let y = size.height * 0.7 + cos(phase) * 8
            let building = CGRect(x: x, y: y, width: 24 + CGFloat(i) * 7, height: size.height * (0.25 + 0.09 * Double(i)))
            let color = Color(hue: 0.65 + 0.08 * Double(i), saturation: 0.8, brightness: 0.9, opacity: 0.33)
            context.fill(
                Path(building),
                with: .color(color)
            )
        }
    }

    private func drawHaze(context: GraphicsContext, size: CGSize) {
        let hazeCenter = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
        context.fill(
            Path(ellipseIn: CGRect(x: hazeCenter.x - 180, y: hazeCenter.y - 40, width: 360, height: 90)),
            with: .radialGradient(
                .init(colors: [Color.cyan.opacity(0.18), Color.purple.opacity(0.06), .clear]),
                center: .init(x: 0.5, y: 0.5),
                startRadius: 10,
                endRadius: 180
            )
        )
    }

    private func drawParticles(context: GraphicsContext, size: CGSize, t: Double) {
        for i in 0..<28 {
            let angle = t * 0.2 + Double(i) * .pi / 14
            let radius = 90 + sin(t * 0.33 + Double(i)) * 30
            let x = size.width * 0.5 + cos(angle) * radius
            let y = size.height * 0.7 + sin(angle) * radius * 0.22
            let particleRect = CGRect(x: x - 2, y: y - 2, width: 4, height: 4)
            let color = [Color.cyan, Color.pink, Color.blue, Color.purple, Color.white].randomElement()!.opacity(0.55)
            context.fill(
                Path(ellipseIn: particleRect),
                with: .color(color)
            )
        }
    }

    private func drawStreaks(context: GraphicsContext, size: CGSize, t: Double) {
        for i in 0..<3 {
            let streakY = size.height * (0.5 + 0.08 * Double(i)) + sin(t * 0.7 + Double(i)) * 12
            let streakOpacity = 0.12 + 0.10 * Double(i)
            let streakGradient = Gradient(colors: [
                Color.cyan.opacity(streakOpacity),
                Color.white.opacity(0.01),
                Color.pink.opacity(streakOpacity)
            ])
            let streakPath = Path { path in
                path.move(to: CGPoint(x: 0, y: streakY))
                path.addCurve(to: CGPoint(x: size.width, y: streakY + 12),
                              control1: CGPoint(x: size.width * 0.3, y: streakY - 18),
                              control2: CGPoint(x: size.width * 0.7, y: streakY + 20))
            }
            context.stroke(
                streakPath,
                with: .linearGradient(
                    streakGradient,
                    startPoint: CGPoint(x: 0, y: streakY),
                    endPoint: CGPoint(x: size.width, y: streakY + 12)
                ),
                lineWidth: 4 + CGFloat(i) * 2
            )
        }
    }

    private func drawFlicker(context: GraphicsContext, size: CGSize, t: Double) {
        let flicker = 0.85 + 0.15 * abs(sin(t * 2.5 + cos(t * 1.4)))
        let flickerRect = CGRect(x: size.width * 0.18, y: size.height * 0.08, width: size.width * 0.64, height: size.height * 0.22)
        context.stroke(
            Path(roundedRect: flickerRect, cornerRadius: 32),
            with: .color(Color.cyan.opacity(0.18 * flicker)),
            lineWidth: 6.5
        )
    }
}

#Preview {
    CyberpunkHeroBackgroundView()
}
