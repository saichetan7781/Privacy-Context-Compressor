import SwiftUI

struct PrivacyFeature: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let symbol: String
    let isEnabled: Bool

    var tint: Color {
        isEnabled ? .green : .secondary
    }
}
