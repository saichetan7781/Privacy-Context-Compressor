import CoreML
import SwiftUI

struct ContextCompressionDashboardView: View {
    @State private var selectedDomain: SystemsDomain = .coreML
    @State private var selectedCompute: MLComputeUnits = .all
    @State private var searchText = ""
    @State private var selectedNote: SystemsNote? = SystemsKnowledgeBase.notes.first
    @StateObject private var privacy = PrivacyPreferences()

    private var filteredNotes: [SystemsNote] {
        SystemsKnowledgeBase.notes.filter { note in
            let domainMatch = note.domain == selectedDomain
            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            guard !query.isEmpty else { return domainMatch }
            return domainMatch && note.searchBlob.contains(query)
        }
    }

    var body: some View {
        NavigationSplitView {
            sidebar
        } detail: {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HeroPanel(domain: selectedDomain)
                    PrivacyPanel(privacy: privacy)
                    FederatedCompressionPanel()
                    CoreMLReadinessPanel(computeUnits: selectedCompute)
                    DomainMetricsPanel(domain: selectedDomain)
                    NotesDetailPanel(note: selectedNote ?? filteredNotes.first)
                    NativeFrameworkMap(domain: selectedDomain)
                }
                .padding(24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(selectedDomain.title)
        }
    }

    private var sidebar: some View {
        List(selection: $selectedNote) {
            Section("Domains") {
                ForEach(SystemsDomain.allCases) { domain in
                    Button {
                        selectedDomain = domain
                        selectedNote = SystemsKnowledgeBase.notes.first { $0.domain == domain }
                    } label: {
                        Label(domain.title, systemImage: domain.symbol)
                    }
                }
            }

            Section("Core ML Compute") {
                Picker("Compute", selection: $selectedCompute) {
                    Text("All").tag(MLComputeUnits.all)
                    Text("CPU + GPU").tag(MLComputeUnits.cpuAndGPU)
                    Text("CPU + Neural Engine").tag(MLComputeUnits.cpuAndNeuralEngine)
                    Text("CPU Only").tag(MLComputeUnits.cpuOnly)
                }
                .pickerStyle(.menu)
            }

            Section("Privacy") {
                Toggle("Local only", isOn: $privacy.localOnlyInference)
                Toggle("Telemetry", isOn: $privacy.telemetryEnabled)
                Toggle("Redact notes", isOn: $privacy.redactSensitiveNotes)
                Toggle("Minimize data", isOn: $privacy.dataMinimization)
                Toggle("Review exports", isOn: $privacy.exportReviewRequired)
            }

            Section("Notes") {
                ForEach(filteredNotes) { note in
                    Label(note.title, systemImage: note.domain.symbol)
                        .tag(Optional(note))
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search privacy context topics")
        .navigationTitle("Privacy Context Compressor")
    }
}
