import CoreML
import SwiftUI

struct CoreMLReadinessPanel: View {
    let computeUnits: MLComputeUnits

    private var computeLabel: String {
        switch computeUnits {
        case .all: return "CPU, GPU, and Neural Engine"
        case .cpuAndGPU: return "CPU and GPU"
        case .cpuOnly: return "CPU only"
        case .cpuAndNeuralEngine: return "CPU and Neural Engine"
        @unknown default: return "Platform default"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label("Core ML Deployment Readiness", systemImage: "brain.head.profile")
                .font(.headline)

            HStack(spacing: 12) {
                MetricTile(title: "Compute Units", value: computeLabel, symbol: "cpu")
                MetricTile(title: "Model Path", value: "mlpackage or compiled mlmodelc", symbol: "shippingbox")
                MetricTile(title: "Runtime Goal", value: "Low latency, private inference", symbol: "bolt.horizontal")
            }

            VStack(alignment: .leading, spacing: 8) {
                ChecklistRow(text: "Convert PyTorch or TensorFlow models with coremltools")
                ChecklistRow(text: "Profile Neural Engine, GPU, and CPU fallback behavior")
                ChecklistRow(text: "Use quantization and flexible input shapes where accuracy allows")
                ChecklistRow(text: "Keep preprocessing native with Vision, Core Image, or Accelerate")
            }
        }
        .panelStyle()
    }
}
