import Foundation

final class FederatedCompressionTrainer: ObservableObject {
    @Published private(set) var rounds: [FederatedRound] = []
    @Published private(set) var policy: CompressionPolicy = .baseline

    private let clippingNorm = 0.08
    private let learningRate = 0.18
    private let differentialPrivacyScale = 0.006

    init() {
        runSimulation()
    }

    func runSimulation() {
        var current = CompressionPolicy.baseline
        var generatedRounds: [FederatedRound] = []
        let samples = Self.syntheticDeviceSamples

        for round in 1...5 {
            let updates = samples.chunked(into: 4).map { deviceSamples in
                makeDeviceUpdate(samples: deviceSamples, current: current)
            }

            let aggregate = secureAggregate(updates: updates)
            current = apply(update: aggregate, to: current)

            let utility = samples.map { predictedUtility(sample: $0, policy: current) }.reduce(0, +) / Double(samples.count)
            generatedRounds.append(
                FederatedRound(
                    round: round,
                    participatingDevices: updates.count,
                    averageUtility: utility,
                    privacyBudgetEpsilon: 1.0 + Double(round) * 0.35,
                    policy: current
                )
            )
        }

        policy = current
        rounds = generatedRounds
    }

    private func makeDeviceUpdate(samples: [CompressionSample], current: CompressionPolicy) -> DeviceUpdate {
        let localUtility = samples.map(\.utilityScore).reduce(0, +) / Double(max(samples.count, 1))
        let targetQuality = samples.map(\.qualityLoss).reduce(0, +) / Double(max(samples.count, 1))
        let targetLatency = samples.map(\.latencyMS).reduce(0, +) / Double(max(samples.count, 1))
        let targetMemory = samples.map(\.memoryMB).reduce(0, +) / Double(max(samples.count, 1))

        var gradient = CompressionPolicy(
            errorBoundWeight: (localUtility - current.errorBoundWeight) * 0.05,
            latencyWeight: (min(targetLatency / 100.0, 1.0) - current.latencyWeight) * 0.08,
            qualityWeight: (min(targetQuality / 0.02, 1.0) - current.qualityWeight) * 0.10,
            memoryWeight: (min(targetMemory / 1024.0, 1.0) - current.memoryWeight) * 0.06
        )

        gradient = clip(gradient)
        return DeviceUpdate(gradient: gradient, sampleCount: samples.count)
    }

    private func secureAggregate(updates: [DeviceUpdate]) -> CompressionPolicy {
        let totalSamples = max(updates.map(\.sampleCount).reduce(0, +), 1)

        let weighted = updates.reduce(CompressionPolicy(errorBoundWeight: 0, latencyWeight: 0, qualityWeight: 0, memoryWeight: 0)) { partial, update in
            let weight = Double(update.sampleCount) / Double(totalSamples)
            return CompressionPolicy(
                errorBoundWeight: partial.errorBoundWeight + update.gradient.errorBoundWeight * weight,
                latencyWeight: partial.latencyWeight + update.gradient.latencyWeight * weight,
                qualityWeight: partial.qualityWeight + update.gradient.qualityWeight * weight,
                memoryWeight: partial.memoryWeight + update.gradient.memoryWeight * weight
            )
        }

        return CompressionPolicy(
            errorBoundWeight: weighted.errorBoundWeight + deterministicNoise(seed: 11),
            latencyWeight: weighted.latencyWeight + deterministicNoise(seed: 17),
            qualityWeight: weighted.qualityWeight + deterministicNoise(seed: 23),
            memoryWeight: weighted.memoryWeight + deterministicNoise(seed: 31)
        )
    }

    private func apply(update: CompressionPolicy, to current: CompressionPolicy) -> CompressionPolicy {
        normalize(
            CompressionPolicy(
                errorBoundWeight: current.errorBoundWeight + learningRate * update.errorBoundWeight,
                latencyWeight: current.latencyWeight + learningRate * update.latencyWeight,
                qualityWeight: current.qualityWeight + learningRate * update.qualityWeight,
                memoryWeight: current.memoryWeight + learningRate * update.memoryWeight
            )
        )
    }

    private func predictedUtility(sample: CompressionSample, policy: CompressionPolicy) -> Double {
        let compressionTerm = policy.errorBoundWeight * min(sample.compressionRatio / 12.0, 1.0)
        let latencyTerm = policy.latencyWeight * (1.0 - min(sample.latencyMS / 100.0, 1.0))
        let qualityTerm = policy.qualityWeight * (1.0 - min(sample.qualityLoss / 0.02, 1.0))
        let memoryTerm = policy.memoryWeight * (1.0 - min(sample.memoryMB / 1024.0, 1.0))
        return compressionTerm + latencyTerm + qualityTerm + memoryTerm
    }

    private func clip(_ gradient: CompressionPolicy) -> CompressionPolicy {
        let norm = sqrt(
            gradient.errorBoundWeight * gradient.errorBoundWeight +
            gradient.latencyWeight * gradient.latencyWeight +
            gradient.qualityWeight * gradient.qualityWeight +
            gradient.memoryWeight * gradient.memoryWeight
        )
        guard norm > clippingNorm else { return gradient }
        let scale = clippingNorm / norm
        return CompressionPolicy(
            errorBoundWeight: gradient.errorBoundWeight * scale,
            latencyWeight: gradient.latencyWeight * scale,
            qualityWeight: gradient.qualityWeight * scale,
            memoryWeight: gradient.memoryWeight * scale
        )
    }

    private func normalize(_ policy: CompressionPolicy) -> CompressionPolicy {
        let values = [
            max(policy.errorBoundWeight, 0.01),
            max(policy.latencyWeight, 0.01),
            max(policy.qualityWeight, 0.01),
            max(policy.memoryWeight, 0.01)
        ]
        let sum = values.reduce(0, +)
        return CompressionPolicy(
            errorBoundWeight: values[0] / sum,
            latencyWeight: values[1] / sum,
            qualityWeight: values[2] / sum,
            memoryWeight: values[3] / sum
        )
    }

    private func deterministicNoise(seed: Int) -> Double {
        let x = sin(Double(seed) * 12.9898) * 43758.5453
        let centered = (x - floor(x)) - 0.5
        return centered * differentialPrivacyScale
    }

    static let syntheticDeviceSamples: [CompressionSample] = [
        .init(workload: "Core ML vision feature cache", deviceClass: "iPhone Pro", errorBound: 0.001, compressionRatio: 8.9, latencyMS: 18, qualityLoss: 0.003, memoryMB: 220),
        .init(workload: "Personal audio embedding cache", deviceClass: "iPhone", errorBound: 0.002, compressionRatio: 10.8, latencyMS: 14, qualityLoss: 0.004, memoryMB: 160),
        .init(workload: "On-device search index vectors", deviceClass: "iPad", errorBound: 0.001, compressionRatio: 7.4, latencyMS: 26, qualityLoss: 0.002, memoryMB: 310),
        .init(workload: "AR scene understanding features", deviceClass: "iPhone Pro", errorBound: 0.0005, compressionRatio: 5.2, latencyMS: 34, qualityLoss: 0.001, memoryMB: 620),
        .init(workload: "Health trend model summaries", deviceClass: "Apple Watch", errorBound: 0.003, compressionRatio: 12.4, latencyMS: 9, qualityLoss: 0.006, memoryMB: 80),
        .init(workload: "Siri local intent embeddings", deviceClass: "iPhone", errorBound: 0.0015, compressionRatio: 9.7, latencyMS: 16, qualityLoss: 0.003, memoryMB: 140),
        .init(workload: "Photos semantic cache", deviceClass: "Mac", errorBound: 0.001, compressionRatio: 6.8, latencyMS: 21, qualityLoss: 0.002, memoryMB: 480),
        .init(workload: "Keyboard personalization features", deviceClass: "iPhone", errorBound: 0.004, compressionRatio: 13.1, latencyMS: 7, qualityLoss: 0.007, memoryMB: 60)
    ]
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}
