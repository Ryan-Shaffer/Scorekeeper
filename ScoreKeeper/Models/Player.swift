import Foundation

struct Player: Identifiable, Equatable {
    let id: UUID
    var name: String
    var roundScores: [Int]

    var totalScore: Int {
        roundScores.reduce(0, +)
    }

    init(id: UUID = UUID(), name: String, roundScores: [Int] = [0]) {
        self.id = id
        self.name = name
        self.roundScores = roundScores
    }

    func score(forRound round: Int) -> Int {
        let index = round - 1
        guard roundScores.indices.contains(index) else { return 0 }
        return roundScores[index]
    }
}
