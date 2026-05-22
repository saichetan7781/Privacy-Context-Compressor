import SwiftUI

struct HeroPanel: View {
    let domain: SystemsDomain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: domain.symbol)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(domain.tint)
                    .frame(width: 44, height: 44)
                    .background(domain.tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 4) {
                    Text(domain.title)
                        .font(.title2.weight(.semibold))
                    Text(domain.subtitle)
                        .foregroundStyle(.secondary)
                }
            }

            Text(domain.summary)
                .font(.body)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .panelStyle()
    }
}
