import Foundation

enum SystemsKnowledgeBase {
    static let notes: [SystemsNote] = [
        .init(
            domain: .coreML,
            title: "Core ML Runtime Strategy",
            body: "Package models with flexible input shapes, benchmark compute units, and keep pre/post-processing native so the runtime can avoid avoidable memory copies.",
            frameworks: ["CoreML", "Vision", "Create ML"],
            priority: .implementation
        ),
        .init(
            domain: .coreML,
            title: "Model Conversion Checklist",
            body: "Convert through coremltools, validate numerics against the source model, quantize only after accuracy checks, then profile cold and warm inference.",
            frameworks: ["coremltools", "MLModelConfiguration"],
            priority: .foundation
        ),
        .init(
            domain: .highPerformanceComputing,
            title: "Metal Compute Pipeline",
            body: "Move repeated arithmetic into Metal kernels or MPS graphs when tensor sizes justify dispatch overhead. Keep buffers reusable and align memory layout with access patterns.",
            frameworks: ["Metal", "MPS", "MTLBuffer"],
            priority: .optimization
        ),
        .init(
            domain: .highPerformanceComputing,
            title: "Accelerate First Pass",
            body: "Use vDSP, vImage, BNNS, and simd for CPU-side math before writing custom kernels. Accelerate often gives production-grade performance with less code.",
            frameworks: ["Accelerate", "vDSP", "BNNS", "simd"],
            priority: .implementation
        ),
        .init(
            domain: .onDeviceAI,
            title: "Private Inference Pattern",
            body: "Keep sensitive features local, log only aggregate metrics, and design graceful CPU fallback for devices without the desired accelerator path.",
            frameworks: ["CoreML", "OSLog", "Security"],
            priority: .privacy
        ),
        .init(
            domain: .onDeviceAI,
            title: "Thermal and Battery Guardrails",
            body: "Throttle background inference, batch work opportunistically, and observe latency under realistic device temperature instead of simulator-only testing.",
            frameworks: ["ProcessInfo", "MetricKit", "CoreML"],
            priority: .optimization
        ),
        .init(
            domain: .federatedCompression,
            title: "Personal Context Compression Policy",
            body: "Learn how aggressively to compress personal context used by Apple Intelligence style features. Devices share clipped noisy policy updates, not raw Mail, Notes, Photos, Calendar, Health, Siri, keyboard, notification, or feature tensor data.",
            frameworks: ["CoreML", "CryptoKit", "MetricKit"],
            priority: .privacy
        ),
        .init(
            domain: .federatedCompression,
            title: "Context Quality Objective",
            body: "Optimize a multi-objective policy that balances compression ratio, latency, quality loss, and memory pressure. This mirrors the CAESAR error-bound tradeoff while applying it to personal context for on-device foundation model workflows.",
            frameworks: ["Accelerate", "Metal", "CoreML"],
            priority: .optimization
        ),
        .init(
            domain: .coreOS,
            title: "Core OS Mental Model",
            body: "Treat memory pressure, scheduling, file coordination, sandboxing, and entitlement boundaries as first-class design constraints for Apple platforms.",
            frameworks: ["Foundation", "Dispatch", "Security"],
            priority: .foundation
        ),
        .init(
            domain: .coreOS,
            title: "I/O and Memory Movement",
            body: "Prefer streaming and mapped access when possible. Extra full-size copies are often the hidden cost in data-heavy native applications.",
            frameworks: ["FileHandle", "DispatchIO", "Foundation"],
            priority: .optimization
        ),
        .init(
            domain: .nativeFrameworks,
            title: "Native Stack Integration",
            body: "Compose SwiftUI, App Intents, CloudKit, Core Data, AVFoundation, and Vision around user workflows instead of treating frameworks as isolated demos.",
            frameworks: ["SwiftUI", "App Intents", "CloudKit"],
            priority: .implementation
        ),
        .init(
            domain: .nativeFrameworks,
            title: "Production Observability",
            body: "Use OSLog, MetricKit, signposts, and Instruments to make performance visible across launch, inference, storage, and UI responsiveness.",
            frameworks: ["OSLog", "MetricKit", "Instruments"],
            priority: .optimization
        ),
        .init(
            domain: .privacy,
            title: "Privacy Manifest Discipline",
            body: "Keep the privacy manifest aligned with actual data use. Treat every new SDK, storage path, and export path as a privacy review trigger.",
            frameworks: ["PrivacyInfo.xcprivacy", "Security", "OSLog"],
            priority: .privacy
        ),
        .init(
            domain: .privacy,
            title: "Local-first Data Handling",
            body: "Default to local storage and local inference. Add network sync only behind an explicit user-controlled flow with clear data boundaries.",
            frameworks: ["CoreData", "CloudKit", "CryptoKit"],
            priority: .privacy
        )
    ]
}
