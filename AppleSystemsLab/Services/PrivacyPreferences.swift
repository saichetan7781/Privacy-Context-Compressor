import SwiftUI

final class PrivacyPreferences: ObservableObject {
    @AppStorage("privacy.localOnlyInference") var localOnlyInference = true
    @AppStorage("privacy.telemetryEnabled") var telemetryEnabled = false
    @AppStorage("privacy.redactSensitiveNotes") var redactSensitiveNotes = true
    @AppStorage("privacy.dataMinimization") var dataMinimization = true
    @AppStorage("privacy.exportReviewRequired") var exportReviewRequired = true

    var features: [PrivacyFeature] {
        [
            .init(
                title: "Local-only inference",
                detail: "Model inputs and derived features stay on device unless the user explicitly exports them.",
                symbol: "iphone",
                isEnabled: localOnlyInference
            ),
            .init(
                title: "Telemetry disabled",
                detail: "The default mode avoids analytics collection and favors local performance observation.",
                symbol: "dot.radiowaves.left.and.right",
                isEnabled: !telemetryEnabled
            ),
            .init(
                title: "Sensitive note redaction",
                detail: "Journal summaries hide potentially sensitive note content before sharing.",
                symbol: "text.viewfinder",
                isEnabled: redactSensitiveNotes
            ),
            .init(
                title: "Data minimization",
                detail: "The app stores only what is needed for the current local workflow.",
                symbol: "tray.and.arrow.down",
                isEnabled: dataMinimization
            ),
            .init(
                title: "Export review",
                detail: "Shared summaries require a deliberate review step before leaving the device.",
                symbol: "square.and.arrow.up",
                isEnabled: exportReviewRequired
            )
        ]
    }
}
