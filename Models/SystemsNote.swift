import SwiftUI

struct SystemsNote: Identifiable, Hashable {
    let id = UUID()
    let domain: SystemsDomain
    let title: String
    let body: String
    let frameworks: [String]
    let priority: Priority

    var searchBlob: String {
        ([title, body] + frameworks + [domain.title]).joined(separator: " ").lowercased()
    }
}

enum Priority: String {
    case foundation = "Foundation"
    case implementation = "Implementation"
    case optimization = "Optimization"
    case privacy = "Privacy"

    var tint: Color {
        switch self {
        case .foundation: return .blue
        case .implementation: return .green
        case .optimization: return .orange
        case .privacy: return .mint
        }
    }
}
