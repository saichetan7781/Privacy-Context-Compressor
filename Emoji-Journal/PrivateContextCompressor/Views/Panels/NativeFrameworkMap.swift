import SwiftUI

struct NativeFrameworkMap: View {
    let domain: SystemsDomain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Native Framework Map")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 10)], spacing: 10) {
                ForEach(domain.frameworks, id: \.self) { framework in
                    HStack {
                        Image(systemName: "checkmark.seal")
                            .foregroundStyle(domain.tint)
                        Text(framework)
                            .font(.callout.weight(.medium))
                        Spacer(minLength: 0)
                    }
                    .padding(10)
                    .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .panelStyle()
    }
}
