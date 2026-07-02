import SwiftUI

struct ScoreboardView: View {
    @Bindable var viewModel: GameViewModel
    var onReset: () -> Void

    @State private var showResetConfirmation = false
    @State private var isHistoryExpanded = false

    private var gameState: GameState? {
        viewModel.gameState
    }

    var body: some View {
        Group {
            if let gameState {
                List {
                    Section {
                        ForEach(gameState.players) { player in
                            PlayerScoreRow(
                                player: player,
                                currentRound: gameState.currentRound,
                                isLeader: gameState.leaderIDs.contains(player.id),
                                onDecrement: {
                                    viewModel.adjustScore(playerId: player.id, delta: -1)
                                },
                                onIncrement: {
                                    viewModel.adjustScore(playerId: player.id, delta: 1)
                                }
                            )
                        }
                    } header: {
                        Text("Round \(gameState.currentRound)")
                            .font(.title2.weight(.bold))
                    }

                    if gameState.completedRoundCount > 0 {
                        Section {
                            DisclosureGroup("Round History", isExpanded: $isHistoryExpanded) {
                                ForEach(1...gameState.completedRoundCount, id: \.self) { round in
                                    HStack(alignment: .top) {
                                        Text("R\(round)")
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundStyle(.secondary)
                                            .frame(width: 32, alignment: .leading)
                                        Text(viewModel.roundSummary(for: round))
                                            .font(.subheadline)
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        }
                    }

                    Section {
                        Button {
                            viewModel.advanceRound()
                        } label: {
                            Label("Next Round", systemImage: "arrow.right.circle.fill")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }

                        Button(role: .destructive) {
                            showResetConfirmation = true
                        } label: {
                            Label("Reset Game", systemImage: "arrow.counterclockwise")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            } else {
                ContentUnavailableView(
                    "No Active Game",
                    systemImage: "list.number",
                    description: Text("Start a new game from the setup screen.")
                )
            }
        }
        .navigationTitle("Scoreboard")
        .navigationBarBackButtonHidden(true)
        .alert("Reset Game?", isPresented: $showResetConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Reset", role: .destructive) {
                viewModel.resetGame()
                onReset()
            }
        } message: {
            Text("This will clear all scores and return to setup.")
        }
    }
}

#Preview {
    NavigationStack {
        ScoreboardView(viewModel: {
            let viewModel = GameViewModel()
            viewModel.startGame(playerNames: ["Alice", "Bob", "Charlie"])
            return viewModel
        }(), onReset: {})
    }
}
