import SwiftUI

struct PlayerScoreRow: View {
    let player: Player
    let currentRound: Int
    let isLeader: Bool
    let onDecrement: () -> Void
    let onIncrement: () -> Void

    private var currentRoundScore: Int {
        player.score(forRound: currentRound)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(player.name)
                    .font(.headline)
                if isLeader {
                    Text("Leader")
                        .font(.caption.weight(.semibold))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.accentColor.opacity(0.15))
                        .clipShape(Capsule())
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Total")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(player.totalScore)")
                        .font(.title2.weight(.bold))
                        .monospacedDigit()
                }
            }

            HStack(spacing: 16) {
                Text("Round \(currentRound)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                Button(action: onDecrement) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                }
                .accessibilityLabel("Decrease score for \(player.name)")

                Text("\(currentRoundScore)")
                    .font(.title.weight(.semibold))
                    .monospacedDigit()
                    .frame(minWidth: 44)

                Button(action: onIncrement) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
                .accessibilityLabel("Increase score for \(player.name)")
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
        .background(isLeader ? Color.accentColor.opacity(0.08) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    PlayerScoreRow(
        player: Player(name: "Alice", roundScores: [5, 3]),
        currentRound: 2,
        isLeader: true,
        onDecrement: {},
        onIncrement: {}
    )
    .padding()
}
