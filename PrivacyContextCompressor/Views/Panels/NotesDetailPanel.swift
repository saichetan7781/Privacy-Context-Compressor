import SwiftUI

struct NotesDetailPanel: View {
    let note: SystemsNote?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Implementation Note")
                .font(.headline)

            if let note {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(note.title)
                            .font(.title3.weight(.semibold))
                        Spacer()
                        Text(note.priority.rawValue)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(note.priority.tint.opacity(0.15), in: Capsule())
                            .foregroundStyle(note.priority.tint)
                    }

                    Text(note.body)
                        .foregroundStyle(.secondary)

                    FlowLayout(items: note.frameworks) { framework in
                        Text(framework)
                            .font(.caption.weight(.medium))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(Color.accentColor.opacity(0.12), in: Capsule())
                    }
                }
            } else {
                Text("Select a topic to inspect implementation notes.")
                    .foregroundStyle(.secondary)
            }
        }
        .panelStyle()
    }
}
