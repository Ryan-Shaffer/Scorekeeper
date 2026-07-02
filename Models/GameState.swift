import Foundation

struct GameState {
    var players: [Player]
    var currentRound: Int

    init(players: [Player] = [], currentRound: Int = 1) {
        self.players = players
        self.currentRound = currentRound
    }

    var completedRoundCount: Int {
        max(0, currentRound - 1)
    }

    var leaderIDs: Set<UUID> {
        guard let maxScore = players.map(\.totalScore).max() else { return [] }
        return Set(players.filter { $0.totalScore == maxScore }.map(\.id))
    }
}
