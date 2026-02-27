import XCTest
@testable import SnakeEngine

final class SnakeEngineTests: XCTestCase {
    func testInitialStateIsValid() {
        let game = SnakeGame(seed: 123)
        XCTAssertEqual(game.snake.count, game.config.initialLength)
        XCTAssertEqual(game.phase, .ready)
        XCTAssertEqual(game.score, 0)
        XCTAssertNotNil(game.food)
        if let food = game.food {
            XCTAssertFalse(game.snake.contains(food))
        }
    }

    func testSnakeMovesOneStepOnTick() {
        var game = SnakeGame(
            config: SnakeGameConfig(columns: 10, rows: 10, initialLength: 3, wrapsAtEdges: false),
            seed: 1
        )
        let originalHead = game.snake[0]
        game.tick()
        let nextHead = game.snake[0]
        XCTAssertEqual(nextHead.x, originalHead.x + 1)
        XCTAssertEqual(nextHead.y, originalHead.y)
        XCTAssertEqual(game.snake.count, 3)
    }

    func testReverseDirectionIsIgnored() {
        var game = SnakeGame(
            config: SnakeGameConfig(columns: 12, rows: 12, initialLength: 3, wrapsAtEdges: false),
            seed: 1
        )
        let originalHead = game.snake[0]
        game.setDirection(.left)
        game.tick()
        let nextHead = game.snake[0]
        XCTAssertEqual(nextHead.x, originalHead.x + 1)
        XCTAssertEqual(nextHead.y, originalHead.y)
    }

    func testEatingFoodIncreasesScoreAndLength() {
        var game = SnakeGame(
            config: SnakeGameConfig(columns: 10, rows: 10, initialLength: 3, wrapsAtEdges: false),
            seed: 99
        )
        let head = game.snake[0]
        game.setStateForTesting(
            snake: game.snake,
            direction: .right,
            food: GridPoint(x: head.x + 1, y: head.y),
            score: 0,
            phase: .running
        )

        game.tick()

        XCTAssertEqual(game.score, 1)
        XCTAssertEqual(game.snake.count, 4)
    }

    func testWallCollisionEndsGameWhenNoWrap() {
        var game = SnakeGame(
            config: SnakeGameConfig(columns: 4, rows: 4, initialLength: 3, wrapsAtEdges: false),
            seed: 11
        )
        game.setStateForTesting(
            snake: [
                GridPoint(x: 3, y: 1),
                GridPoint(x: 2, y: 1),
                GridPoint(x: 1, y: 1)
            ],
            direction: .right,
            food: GridPoint(x: 0, y: 0),
            score: 0,
            phase: .running
        )

        game.tick()

        XCTAssertEqual(game.phase, .gameOver)
        XCTAssertFalse(game.didWin)
    }

    func testSelfCollisionEndsGame() {
        var game = SnakeGame(
            config: SnakeGameConfig(columns: 7, rows: 7, initialLength: 3, wrapsAtEdges: false),
            seed: 11
        )
        game.setStateForTesting(
            snake: [
                GridPoint(x: 3, y: 3),
                GridPoint(x: 3, y: 2),
                GridPoint(x: 2, y: 2),
                GridPoint(x: 2, y: 3)
            ],
            direction: .left,
            food: GridPoint(x: 0, y: 0),
            score: 0,
            phase: .running
        )

        game.tick()

        XCTAssertEqual(game.phase, .gameOver)
    }
}
