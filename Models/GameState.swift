import Foundation

struct GameState {
    var teams: [Team]
    var currentRound: Int

    init(teams: [Team] = [], currentRound: Int = 1) {
        self.teams = teams
        self.currentRound = currentRound
    }

    var completedRoundCount: Int {
        max(0, currentRound - 1)
    }

    var leadingTeamIDs: Set<UUID> {
        guard let maxScore = teams.map(\.totalScore).max() else { return [] }
        return Set(teams.filter { $0.totalScore == maxScore }.map(\.id))
    }

    func team(containingPlayerId playerId: UUID) -> (teamIndex: Int, playerIndex: Int)? {
        for teamIndex in teams.indices {
            if let playerIndex = teams[teamIndex].players.firstIndex(where: { $0.id == playerId }) {
                return (teamIndex, playerIndex)
            }
        }
        return nil
    }
}
