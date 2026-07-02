import Foundation
import Observation

@Observable
final class GameViewModel {
    private(set) var gameState: GameState?
    var isGameActive: Bool { gameState != nil }

    func startGame(playerNames: [String]) {
        let trimmedNames = playerNames.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        guard trimmedNames.count >= 2, trimmedNames.count <= 6 else { return }
        guard trimmedNames.allSatisfy({ !$0.isEmpty }) else { return }

        let players = trimmedNames.map { Player(name: $0) }
        gameState = GameState(players: players, currentRound: 1)
    }

    func adjustScore(playerId: UUID, delta: Int) {
        guard var state = gameState else { return }
        guard let index = state.players.firstIndex(where: { $0.id == playerId }) else { return }

        let roundIndex = state.currentRound - 1
        guard state.players[index].roundScores.indices.contains(roundIndex) else { return }

        state.players[index].roundScores[roundIndex] += delta
        gameState = state
    }

    func advanceRound() {
        guard var state = gameState else { return }

        state.currentRound += 1
        for index in state.players.indices {
            state.players[index].roundScores.append(0)
        }
        gameState = state
    }

    func resetGame() {
        gameState = nil
    }

    func roundSummary(for round: Int) -> String {
        guard let state = gameState else { return "" }

        let parts = state.players.map { player in
            "\(player.name) \(player.score(forRound: round))"
        }
        return parts.joined(separator: ", ")
    }
}
