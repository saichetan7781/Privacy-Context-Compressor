import SwiftUI

struct FederatedCompressionPanel: View {
    @StateObject private var trainer = FederatedCompressionTrainer()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Label("Federated Compression Use Case", systemImage: "point.3.connected.trianglepath.dotted")
                    .font(.headline)
                Spacer()
                Button("Rerun") {
                    trainer.runSimulation()
                }
                .buttonStyle(.bordered)
            }

            Text("Use case: learn a device-specific compression policy for Core ML feature caches and on-device model summaries. Raw photos, audio, health signals, text, and feature tensors never leave the device. Each device computes a local policy update from compression ratio, latency, quality loss, and memory pressure, clips the update, adds differential privacy noise, and contributes only the protected update to aggregation.")
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                MetricTile(title: "Recommended Policy", value: trainer.policy.recommendedMode, symbol: "slider.horizontal.3")
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
                Text("Why this is an Apple-relevant ML systems problem")
                    .font(.subheadline.weight(.semibold))
                ChecklistRow(text: "On-device ML features can be large, especially for vision, personalization, search, and multimodal workflows")
                ChecklistRow(text: "Compression must adapt to device class, thermal state, memory pressure, and user quality expectations")
                ChecklistRow(text: "Federated learning lets Apple improve policy quality across devices without collecting private raw data")
                ChecklistRow(text: "Core ML, Metal, Accelerate, MetricKit, CryptoKit, and privacy manifests all fit naturally into the solution")
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
