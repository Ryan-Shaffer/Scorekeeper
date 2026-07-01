import SwiftUI

@main
struct ScoreKeeperApp: App {
    @State private var viewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SetupView(viewModel: viewModel)
            }
        }
    }
}
