import Foundation

struct CompressionSample: Identifiable {
    let id = UUID()
    let workload: String
    let deviceClass: String
    let errorBound: Double
    let compressionRatio: Double
    let latencyMS: Double
    let qualityLoss: Double
    let memoryMB: Double

    var utilityScore: Double {
        let sizeReward = min(compressionRatio / 12.0, 1.0)
        let latencyPenalty = min(latencyMS / 80.0, 1.0)
        let qualityPenalty = min(qualityLoss / 0.02, 1.0)
        let memoryPenalty = min(memoryMB / 1024.0, 1.0)
        return max(0.0, sizeReward - 0.30 * latencyPenalty - 0.45 * qualityPenalty - 0.15 * memoryPenalty)
    }
}

struct CompressionPolicy: Equatable {
    var errorBoundWeight: Double
    var latencyWeight: Double
    var qualityWeight: Double
    var memoryWeight: Double

    static let baseline = CompressionPolicy(
        errorBoundWeight: 0.34,
        latencyWeight: 0.24,
        qualityWeight: 0.30,
        memoryWeight: 0.12
    )

    var recommendedMode: String {
        if qualityWeight > 0.38 { return "Quality-preserving personal context cache" }
        if latencyWeight > 0.30 { return "Low-latency Apple Intelligence context cache" }
        if memoryWeight > 0.20 { return "Memory-pressure aware context compression" }
        return "Balanced private context compression"
    }
}

struct FederatedRound: Identifiable {
    let id = UUID()
    let round: Int
    let participatingDevices: Int
    let averageUtility: Double
    let privacyBudgetEpsilon: Double
    let policy: CompressionPolicy
}

struct DeviceUpdate {
    let gradient: CompressionPolicy
    let sampleCount: Int
}
