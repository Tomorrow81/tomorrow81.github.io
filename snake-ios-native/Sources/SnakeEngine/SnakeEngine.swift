import Foundation

public struct GridPoint: Hashable, Sendable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public enum Direction: CaseIterable, Sendable {
    case up
    case down
    case left
    case right

    func isOpposite(of other: Direction) -> Bool {
        switch (self, other) {
        case (.up, .down), (.down, .up), (.left, .right), (.right, .left):
            return true
        default:
            return false
        }
    }
}

public enum GamePhase: Equatable, Sendable {
    case ready
    case running
    case gameOver
}

public struct SnakeGameConfig: Sendable {
    public let columns: Int
    public let rows: Int
    public let initialLength: Int
    public let wrapsAtEdges: Bool

    public init(
        columns: Int = 20,
        rows: Int = 20,
        initialLength: Int = 3,
        wrapsAtEdges: Bool = false
    ) {
        precondition(columns >= 4, "columns must be at least 4")
        precondition(rows >= 4, "rows must be at least 4")
        precondition(initialLength >= 2, "initialLength must be at least 2")
        precondition(initialLength < columns, "initialLength must be less than columns")

        self.columns = columns
        self.rows = rows
        self.initialLength = initialLength
        self.wrapsAtEdges = wrapsAtEdges
    }
}

public struct SnakeGame: Sendable {
    public private(set) var config: SnakeGameConfig
    public private(set) var snake: [GridPoint]
    public private(set) var direction: Direction
    public private(set) var food: GridPoint?
    public private(set) var score: Int
    public private(set) var phase: GamePhase
    public private(set) var didWin: Bool

    private var queuedDirection: Direction?
    private var random: SeededRandom

    public init(config: SnakeGameConfig = SnakeGameConfig(), seed: UInt64 = 0xC0FFEE) {
        self.config = config
        self.snake = []
        self.direction = .right
        self.food = nil
        self.score = 0
        self.phase = .ready
        self.didWin = false
        self.queuedDirection = nil
        self.random = SeededRandom(seed: seed == 0 ? 0xC0FFEE : seed)
        reset()
    }

    public mutating func reset() {
        queuedDirection = nil
        score = 0
        didWin = false
        phase = .ready
        direction = .right

        let centerY = config.rows / 2
        let headX = max(config.initialLength - 1, config.columns / 2)
        snake = (0..<config.initialLength).map {
            GridPoint(x: headX - $0, y: centerY)
        }

        spawnFood()
    }

    public mutating func start() {
        if phase == .ready {
            phase = .running
        }
    }

    public mutating func setDirection(_ nextDirection: Direction) {
        guard phase != .gameOver else { return }
        guard !nextDirection.isOpposite(of: direction) else { return }
        queuedDirection = nextDirection
    }

    public mutating func tick() {
        guard phase != .gameOver else { return }
        if phase == .ready {
            phase = .running
        }

        if let queuedDirection, !queuedDirection.isOpposite(of: direction) {
            direction = queuedDirection
        }
        self.queuedDirection = nil

        guard let currentHead = snake.first else {
            phase = .gameOver
            return
        }

        let proposedHead = step(from: currentHead, in: direction)
        guard let nextHead = boundedPoint(from: proposedHead) else {
            phase = .gameOver
            return
        }

        let willGrow = nextHead == food
        let collisionBody = willGrow ? snake : Array(snake.dropLast())
        if collisionBody.contains(nextHead) {
            phase = .gameOver
            return
        }

        snake.insert(nextHead, at: 0)
        if willGrow {
            score += 1
            spawnFood()
        } else {
            _ = snake.popLast()
        }
    }

    private func step(from point: GridPoint, in direction: Direction) -> GridPoint {
        switch direction {
        case .up:
            return GridPoint(x: point.x, y: point.y - 1)
        case .down:
            return GridPoint(x: point.x, y: point.y + 1)
        case .left:
            return GridPoint(x: point.x - 1, y: point.y)
        case .right:
            return GridPoint(x: point.x + 1, y: point.y)
        }
    }

    private func boundedPoint(from point: GridPoint) -> GridPoint? {
        if config.wrapsAtEdges {
            let wrappedX = (point.x % config.columns + config.columns) % config.columns
            let wrappedY = (point.y % config.rows + config.rows) % config.rows
            return GridPoint(x: wrappedX, y: wrappedY)
        }

        guard point.x >= 0, point.x < config.columns, point.y >= 0, point.y < config.rows else {
            return nil
        }
        return point
    }

    private mutating func spawnFood() {
        var available: [GridPoint] = []
        let snakeSet = Set(snake)
        for y in 0..<config.rows {
            for x in 0..<config.columns {
                let point = GridPoint(x: x, y: y)
                if !snakeSet.contains(point) {
                    available.append(point)
                }
            }
        }

        guard !available.isEmpty else {
            food = nil
            didWin = true
            phase = .gameOver
            return
        }

        let index = Int(random.next() % UInt64(available.count))
        food = available[index]
    }
}

struct SeededRandom: Sendable {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed == 0 ? 0xDEADBEEF : seed
    }

    mutating func next() -> UInt64 {
        var x = state
        x ^= x << 13
        x ^= x >> 7
        x ^= x << 17
        state = x
        return x
    }
}

extension SnakeGame {
    // Internal testing helper so rules can be unit-tested without UI.
    mutating func setStateForTesting(
        snake: [GridPoint],
        direction: Direction,
        food: GridPoint?,
        score: Int,
        phase: GamePhase
    ) {
        self.snake = snake
        self.direction = direction
        self.food = food
        self.score = score
        self.phase = phase
        self.didWin = false
        self.queuedDirection = nil
    }
}
