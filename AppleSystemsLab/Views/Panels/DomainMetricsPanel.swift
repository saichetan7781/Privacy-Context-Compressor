import SwiftUI

struct DomainMetricsPanel: View {
    let domain: SystemsDomain

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Engineering Focus")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 12)], spacing: 12) {
                ForEach(domain.metrics) { metric in
                    MetricTile(title: metric.title, value: metric.value, symbol: metric.symbol)
                }
            }
        }
        .panelStyle()
    }
}
