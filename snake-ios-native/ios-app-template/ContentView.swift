import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        VStack(spacing: 16) {
            header

            GameBoardView(
                columns: viewModel.game.config.columns,
                rows: viewModel.game.config.rows,
                snake: viewModel.game.snake,
                food: viewModel.game.food
            )
            .gesture(
                DragGesture(minimumDistance: 10)
                    .onEnded(viewModel.handleSwipe)
            )
            .overlay(alignment: .center) {
                if viewModel.game.phase == .gameOver {
                    gameOverOverlay
                }
            }
            .padding(.horizontal, 16)

            controls
        }
        .padding(.vertical, 24)
        .onAppear {
            viewModel.startNewGame()
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text("Snake")
                .font(.largeTitle).bold()
            Text("Score: \(viewModel.game.score)")
                .font(.title3.weight(.semibold))
        }
    }

    private var controls: some View {
        HStack(spacing: 12) {
            Button("Restart") {
                viewModel.startNewGame()
            }
            .buttonStyle(.borderedProminent)

            Button(viewModel.isPaused ? "Resume" : "Pause") {
                viewModel.togglePause()
            }
            .buttonStyle(.bordered)
            .disabled(viewModel.game.phase == .gameOver)
        }
    }

    private var gameOverOverlay: some View {
        VStack(spacing: 10) {
            Text(viewModel.game.didWin ? "You Win" : "Game Over")
                .font(.headline)
            Text("Score: \(viewModel.game.score)")
                .font(.subheadline)
            Button("Play Again") {
                viewModel.startNewGame()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(18)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
}
