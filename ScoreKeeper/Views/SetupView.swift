import SwiftUI

struct SetupView: View {
    @Bindable var viewModel: GameViewModel
    @State private var playerCount = 2
    @State private var playerNames: [String] = ["Player 1", "Player 2"]
    @State private var navigateToScoreboard = false

    private var canStartGame: Bool {
        playerNames.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    var body: some View {
        Form {
            Section {
                Stepper(value: $playerCount, in: 2...6) {
                    Text("Players: \(playerCount)")
                        .font(.headline)
                }
                .onChange(of: playerCount) { _, newValue in
                    updatePlayerNames(for: newValue)
                }
            } header: {
                Text("Game Setup")
            } footer: {
                Text("Choose 2 to 6 players for this game.")
            }

            Section("Player Names") {
                ForEach(0..<playerNames.count, id: \.self) { index in
                    TextField("Player \(index + 1)", text: $playerNames[index])
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                }
            }

            Section {
                Button {
                    viewModel.startGame(playerNames: playerNames)
                    navigateToScoreboard = true
                } label: {
                    Text("Start Game")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .disabled(!canStartGame)
                .listRowBackground(canStartGame ? Color.accentColor : Color.gray.opacity(0.3))
                .foregroundStyle(.white)
            }
        }
        .navigationTitle("ScoreKeeper")
        .navigationDestination(isPresented: $navigateToScoreboard) {
            if viewModel.isGameActive {
                ScoreboardView(viewModel: viewModel, onReset: {
                    navigateToScoreboard = false
                })
            }
        }
    }

    private func updatePlayerNames(for count: Int) {
        if count > playerNames.count {
            for index in playerNames.count..<count {
                playerNames.append("Player \(index + 1)")
            }
        } else if count < playerNames.count {
            playerNames = Array(playerNames.prefix(count))
        }
    }
}

#Preview {
    NavigationStack {
        SetupView(viewModel: GameViewModel())
    }
}
