import SwiftUI
import SnakeEngine

struct GameBoardView: View {
    let columns: Int
    let rows: Int
    let snake: [GridPoint]
    let food: GridPoint?

    var body: some View {
        GeometryReader { geo in
            let boardSide = min(geo.size.width, geo.size.height)
            let cellSize = boardSide / CGFloat(max(columns, rows))

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.9))

                gridOverlay(boardSide: boardSide, cellSize: cellSize)

                ForEach(Array(snake.enumerated()), id: \.element) { index, segment in
                    RoundedRectangle(cornerRadius: index == 0 ? 7 : 4)
                        .fill(index == 0 ? Color.green : Color.green.opacity(0.75))
                        .frame(width: cellSize, height: cellSize)
                        .offset(x: CGFloat(segment.x) * cellSize, y: CGFloat(segment.y) * cellSize)
                }

                if let food {
                    Circle()
                        .fill(Color.red)
                        .frame(width: cellSize * 0.8, height: cellSize * 0.8)
                        .offset(
                            x: CGFloat(food.x) * cellSize + (cellSize * 0.1),
                            y: CGFloat(food.y) * cellSize + (cellSize * 0.1)
                        )
                }
            }
            .frame(width: boardSide, height: boardSide, alignment: .topLeading)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    @ViewBuilder
    private func gridOverlay(boardSide: CGFloat, cellSize: CGFloat) -> some View {
        Path { path in
            for x in 0...columns {
                let xPos = CGFloat(x) * cellSize
                path.move(to: CGPoint(x: xPos, y: 0))
                path.addLine(to: CGPoint(x: xPos, y: boardSide))
            }
            for y in 0...rows {
                let yPos = CGFloat(y) * cellSize
                path.move(to: CGPoint(x: 0, y: yPos))
                path.addLine(to: CGPoint(x: boardSide, y: yPos))
            }
        }
        .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
    }
}
