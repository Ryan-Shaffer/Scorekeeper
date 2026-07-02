# ScoreKeeper

A native SwiftUI iPhone app for round-based scorekeeping. Track 2–6 players, enter scores per round, see running totals, and review past rounds.

## Requirements

- macOS with **Xcode 15+**
- iOS 17+ deployment target (Simulator or physical iPhone)

## One-time Xcode setup

1. On your Mac, open **Xcode → File → New → Project**.
2. Choose **iOS → App**.
3. Configure the project:
   - **Product Name:** `ScoreKeeper`
   - **Interface:** SwiftUI
   - **Language:** Swift
   - **Minimum Deployments:** iOS 17.0
4. Save the project inside this folder (or clone/copy this repo next to your Xcode project).
5. In Xcode, delete the default `ContentView.swift` (and any other placeholder views) if present.
6. Add the source files from this repo to the Xcode project:
   - Drag the `Models`, `ViewModels`, and `Views` folders into the project navigator, or use **File → Add Files to "ScoreKeeper"...**
   - Replace the generated app entry file with `ScoreKeeperApp.swift` (ensure only one `@main` entry exists).
7. Confirm all Swift files are checked under the **ScoreKeeper** app target in the File Inspector.

## Run the app

1. Select an iPhone Simulator (e.g. iPhone 16) or your connected device.
2. Press **Cmd+R** to build and run.

## Manual test checklist

- [ ] Player count is limited to 2–6
- [ ] Start Game is disabled when any name is blank
- [ ] +/− buttons update the current round score
- [ ] Totals equal the sum of all round scores
- [ ] Next Round advances without losing prior rounds
- [ ] Round History shows completed rounds
- [ ] Reset Game clears scores and returns to setup

## Project structure

```
ScoreKeeper/
├── ScoreKeeperApp.swift
├── Models/
│   ├── Player.swift
│   └── GameState.swift
├── ViewModels/
│   └── GameViewModel.swift
└── Views/
    ├── SetupView.swift
    ├── ScoreboardView.swift
    └── PlayerScoreRow.swift
```

## Syncing between Windows and Mac

Edit Swift source in Cursor on Windows, then push/pull via git (or copy the folder) to your Mac before building in Xcode. SwiftUI apps must be compiled on macOS.

## App Store (future)

This MVP stores no user data. To ship later you will need an Apple Developer account, app icon, and an App Store Connect submission.
