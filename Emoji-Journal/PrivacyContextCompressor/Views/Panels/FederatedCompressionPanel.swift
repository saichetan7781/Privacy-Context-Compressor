import SwiftUI

struct FederatedCompressionPanel: View {
    @StateObject private var trainer = FederatedCompressionTrainer()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label("Private Personal Context Compression", systemImage: "point.3.connected.trianglepath.dotted")
                    .font(.headline)
                Spacer()
                Button("Rerun") {
                    trainer.runSimulation()
                }
                .buttonStyle(.bordered)
            }

            Text("Use case: learn how much personal context an Apple Intelligence style on-device model can compress before quality degrades. Raw Mail, Notes, Photos, Calendar, Health, Siri, keyboard, and notification content never leaves the device. Each device computes a local update from compression ratio, latency, quality loss, and memory pressure, clips the update, adds differential privacy noise, and contributes only the protected update to aggregation.")
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                MetricTile(title: "Recommended Context Policy", value: trainer.policy.recommendedMode, symbol: "slider.horizontal.3")
                MetricTile(title: "Privacy Method", value: "Clipping plus DP noise", symbol: "lock.shield")
                MetricTile(title: "Raw Data Upload", value: "None", symbol: "xmark.seal")
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Federated Rounds")
                    .font(.subheadline.weight(.semibold))

                ForEach(trainer.rounds) { round in
                    FederatedRoundRow(round: round)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Why this is a real Apple Intelligence systems problem")
                    .font(.subheadline.weight(.semibold))
                ChecklistRow(text: "Apple Intelligence relies on personal context, but that context must remain private and efficient on device")
                ChecklistRow(text: "Context caches for summaries, prioritization, writing assistance, and in-app actions can compete with memory, battery, and latency budgets")
                ChecklistRow(text: "Federated learning can improve compression policy quality across devices without collecting private raw content")
                ChecklistRow(text: "Core ML, Accelerate, MetricKit, CryptoKit, and privacy manifests fit naturally into this on-device solution")
            }
        }
        .panelStyle()
    }
}

private struct FederatedRoundRow: View {
    let round: FederatedRound

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Round \(round.round)")
                    .font(.callout.weight(.semibold))
                Spacer()
                Text("epsilon \(round.privacyBudgetEpsilon, specifier: "%.2f")")
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: round.averageUtility, total: 1.0) {
                Text("Average protected utility")
                    .font(.caption)
            }

            HStack {
                Text("Devices: \(round.participatingDevices)")
                Spacer()
                Text(round.policy.recommendedMode)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 8))
    }
}
