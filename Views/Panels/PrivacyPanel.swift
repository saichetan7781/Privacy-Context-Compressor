import SwiftUI

struct PrivacyPanel: View {
    @ObservedObject var privacy: PrivacyPreferences

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Privacy Controls", systemImage: "lock.shield")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 190), spacing: 12)], spacing: 12) {
                ForEach(privacy.features) { feature in
                    VStack(alignment: .leading, spacing: 8) {
                        Image(systemName: feature.symbol)
                            .foregroundStyle(feature.tint)
                        Text(feature.title)
                            .font(.callout.weight(.semibold))
                        Text(feature.detail)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .panelStyle()
    }
}
