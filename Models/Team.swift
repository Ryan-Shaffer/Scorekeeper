import Foundation

struct Team: Identifiable, Equatable {
    let id: UUID
    var name: String
    var players: [Player]

    var totalScore: Int {
        players.map(\.totalScore).reduce(0, +)
    }

    init(id: UUID = UUID(), name: String, players: [Player] = []) {
        self.id = id
        self.name = name
        self.players = players
    }

    func score(forRound round: Int) -> Int {
        players.map { $0.score(forRound: round) }.reduce(0, +)
    }

    func roundSummary(for round: Int) -> String {
        let parts = players.map { "\($0.name) \($0.score(forRound: round))" }
        return parts.joined(separator: ", ")
    }
}
