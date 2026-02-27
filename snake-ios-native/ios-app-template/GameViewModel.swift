import Foundation
import SwiftUI
import SnakeEngine

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var game: SnakeGame
    @Published private(set) var isPaused = false

    let tickInterval: TimeInterval
    private var timer: Timer?

    init(tickInterval: TimeInterval = 0.16) {
        self.tickInterval = tickInterval
        self.game = SnakeGame()
    }

    deinit {
        timer?.invalidate()
    }

    func startNewGame() {
        game.reset()
        game.start()
        isPaused = false
        restartTimer()
    }

    func togglePause() {
        guard game.phase != .gameOver else { return }
        isPaused.toggle()
        if isPaused {
            stopTimer()
        } else {
            restartTimer()
        }
    }

    func setDirection(_ direction: Direction) {
        guard !isPaused, game.phase != .gameOver else { return }
        game.setDirection(direction)
    }

    func handleSwipe(_ value: DragGesture.Value) {
        let dx = value.translation.width
        let dy = value.translation.height
        guard abs(dx) > 8 || abs(dy) > 8 else { return }

        if abs(dx) > abs(dy) {
            setDirection(dx > 0 ? .right : .left)
        } else {
            setDirection(dy > 0 ? .down : .up)
        }
    }

    private func tick() {
        guard !isPaused else { return }
        game.tick()
        if game.phase == .gameOver {
            stopTimer()
        }
    }

    private func restartTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: tickInterval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
