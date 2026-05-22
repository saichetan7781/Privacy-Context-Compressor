import SwiftUI

enum SystemsDomain: String, CaseIterable, Identifiable {
    case coreML
    case highPerformanceComputing
    case onDeviceAI
    case federatedCompression
    case coreOS
    case nativeFrameworks
    case privacy

    var id: String { rawValue }

    var title: String {
        switch self {
        case .coreML: return "Core ML"
        case .highPerformanceComputing: return "High Performance Computing"
        case .onDeviceAI: return "On-Device Intelligence"
        case .federatedCompression: return "Federated Compression"
        case .coreOS: return "Core OS"
        case .nativeFrameworks: return "Apple Native Technologies"
        case .privacy: return "Privacy Engineering"
        }
    }

    var subtitle: String {
        switch self {
        case .coreML: return "Model conversion, deployment, and runtime control"
        case .highPerformanceComputing: return "Metal, Accelerate, MPS, memory, and throughput"
        case .onDeviceAI: return "Private, low-latency inference at the edge"
        case .federatedCompression: return "Adaptive compression learned without raw data upload"
        case .coreOS: return "Scheduling, I/O, memory, security, and platform services"
        case .nativeFrameworks: return "The Apple SDK stack for production apps"
        case .privacy: return "Local-first design, minimization, consent, and secure handling"
        }
    }

    var summary: String {
        switch self {
        case .coreML:
            return "Design model pipelines that compile into Core ML packages, select compute units intentionally, and keep preprocessing close to Apple frameworks."
        case .highPerformanceComputing:
            return "Use Metal and Accelerate to reduce memory movement, exploit vectorization, and map compute kernels onto Apple Silicon efficiently."
        case .onDeviceAI:
            return "Push inference onto user devices for privacy, responsiveness, and offline resilience while managing thermals and battery impact."
        case .federatedCompression:
            return "Apply lessons from error-bounded data compression to on-device ML: each device learns how aggressively to compress Core ML feature caches while sharing only clipped, noisy model updates."
        case .coreOS:
            return "Understand the operating system substrate: virtual memory, filesystems, sandboxing, scheduling, dispatch queues, and secure services."
        case .nativeFrameworks:
            return "Build with native APIs first: SwiftUI, Core Data, CloudKit, Vision, AVFoundation, App Intents, and system-level integrations."
        case .privacy:
            return "Treat privacy as a product surface: minimize data, run locally when possible, redact sensitive text, and require explicit export decisions."
        }
    }

    var symbol: String {
        switch self {
        case .coreML: return "brain"
        case .highPerformanceComputing: return "memorychip"
        case .onDeviceAI: return "iphone.gen3.radiowaves.left.and.right"
        case .federatedCompression: return "point.3.connected.trianglepath.dotted"
        case .coreOS: return "gearshape.2"
        case .nativeFrameworks: return "square.stack.3d.up"
        case .privacy: return "lock.shield"
        }
    }

    var tint: Color {
        switch self {
        case .coreML: return .purple
        case .highPerformanceComputing: return .orange
        case .onDeviceAI: return .blue
        case .federatedCompression: return .red
        case .coreOS: return .teal
        case .nativeFrameworks: return .indigo
        case .privacy: return .green
        }
    }

    var frameworks: [String] {
        switch self {
        case .coreML: return ["CoreML", "Vision", "Create ML", "coremltools", "NaturalLanguage"]
        case .highPerformanceComputing: return ["Metal", "Metal Performance Shaders", "Accelerate", "BNNS", "vDSP"]
        case .onDeviceAI: return ["CoreML", "Vision", "App Intents", "Speech", "NaturalLanguage"]
        case .federatedCompression: return ["CoreML", "CryptoKit", "MetricKit", "Accelerate", "CloudKit"]
        case .coreOS: return ["Foundation", "Dispatch", "OSLog", "Security", "FileProvider"]
        case .nativeFrameworks: return ["SwiftUI", "CloudKit", "Core Data", "AVFoundation", "Core Image"]
        case .privacy: return ["Security", "LocalAuthentication", "CryptoKit", "OSLog", "PrivacyInfo.xcprivacy"]
        }
    }

    var metrics: [SystemsMetric] {
        switch self {
        case .coreML:
            return [
                .init(title: "Latency Target", value: "Under 50 ms hot path", symbol: "timer"),
                .init(title: "Deployment", value: "mlpackage or mlmodelc", symbol: "archivebox"),
                .init(title: "Compute", value: "ANE, GPU, CPU", symbol: "cpu")
            ]
        case .highPerformanceComputing:
            return [
                .init(title: "Throughput", value: "Batch and vectorize", symbol: "speedometer"),
                .init(title: "Memory", value: "Minimize copies", symbol: "arrow.left.arrow.right"),
                .init(title: "Kernels", value: "Metal and MPS", symbol: "function")
            ]
        case .onDeviceAI:
            return [
                .init(title: "Privacy", value: "Local inference", symbol: "lock.shield"),
                .init(title: "Resilience", value: "Offline capable", symbol: "wifi.slash"),
                .init(title: "Energy", value: "Thermal aware", symbol: "thermometer.medium")
            ]
        case .federatedCompression:
            return [
                .init(title: "Raw Data", value: "Never uploaded", symbol: "lock"),
                .init(title: "Objective", value: "Size, latency, quality", symbol: "slider.horizontal.3"),
                .init(title: "Aggregation", value: "Clipped noisy updates", symbol: "sum")
            ]
        case .coreOS:
            return [
                .init(title: "Concurrency", value: "Dispatch and actors", symbol: "arrow.triangle.2.circlepath"),
                .init(title: "I/O", value: "Streaming paths", symbol: "externaldrive"),
                .init(title: "Security", value: "Sandbox and entitlements", symbol: "key")
            ]
        case .nativeFrameworks:
            return [
                .init(title: "Interface", value: "SwiftUI native", symbol: "rectangle.3.group"),
                .init(title: "Data", value: "Core Data and CloudKit", symbol: "icloud"),
                .init(title: "Media", value: "AV and Core Image", symbol: "play.rectangle")
            ]
        case .privacy:
            return [
                .init(title: "Telemetry", value: "Off by default", symbol: "dot.radiowaves.left.and.right"),
                .init(title: "Storage", value: "Local first", symbol: "internaldrive"),
                .init(title: "Exports", value: "Explicit review", symbol: "square.and.arrow.up")
            ]
        }
    }
}
