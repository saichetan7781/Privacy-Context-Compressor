# Privacy Context Compressor

Privacy Context Compressor is a SwiftUI prototype for an on-device machine learning systems problem: compressing personal context for Apple Intelligence-style workflows while preserving privacy.

The project models how a device can reduce the memory, latency, storage, and energy cost of personal context caches used by on-device intelligence features. Example context sources include Mail, Notes, Photos, Calendar, Siri, keyboard behavior, notifications, app activity, and Health summaries.

## Use Case

Modern on-device intelligence needs personal context to answer useful questions, summarize content, prioritize information, and personalize actions. That context is sensitive and can become large. This project explores how to compress personal context locally while preserving enough quality for downstream machine learning tasks.

The core question is:

```text
How can a device compress local personal context enough to save memory and latency,
while preserving model quality and never uploading raw private content?
```

## What This App Demonstrates

- Local personal context compression policy simulation
- Privacy-preserving federated learning workflow
- Differential privacy-style noise simulation
- Update clipping before aggregation
- Compression quality versus payload size tradeoffs
- Memory pressure, latency, and performance scoring
- Apple-native app architecture using SwiftUI
- Local-first on-device intelligence design
- Simulation of privacy-aware policy learning without centralizing raw user content

## Context Sources Modeled

The simulator treats the following as representative privacy-sensitive context domains:

- Mail thread summaries
- Notes semantic recall
- Photos memory understanding
- Calendar and reminder action context
- Siri intent personalization
- Keyboard writing style personalization
- Notification priority context
- Health trend explanation context
- App activity and local user workflow signals

Raw content from these domains is never uploaded in the simulator. Only protected aggregate policy updates are modeled.

## Metrics Tracked

The app tracks compression and privacy-related metrics such as:

- Compression ratio
- Context quality loss
- Payload size
- Latency
- Memory pressure
- Energy cost
- Federated round number
- Number of participating simulated devices
- Clipped update norm
- Noise scale
- Aggregated policy improvement
- Recommended compression policy

## Performance Model

The performance model is inspired by error-bounded scientific data compression.

Lower error bounds preserve more context quality but usually increase:

- Payload size
- Runtime
- Memory usage
- Energy cost

Higher error bounds reduce payload size and runtime but may reduce downstream machine learning quality.

The simulator uses this tradeoff to recommend a context compression policy for on-device machine learning workloads.

## Privacy Model

The privacy workflow follows a local-first design:

1. Personal context stays on device.
2. Each device evaluates compression quality locally.
3. A local policy update is generated.
4. The update is clipped to limit contribution size.
5. Differential privacy-style noise is added.
6. Only the protected update is aggregated.
7. Raw personal content is never centralized.

This is a simulator. It does not send data to a server.

## Stack Used

- Swift
- SwiftUI
- Observation and state-driven UI
- AppStorage for local privacy preferences
- Foundation for local simulation logic
- PrivacyInfo.xcprivacy for privacy manifest structure

## Apple Technology Areas Represented

The project is designed around Apple-native systems concepts:

- Core ML for future on-device model deployment
- SwiftUI for native interface development
- Accelerate for future vector and matrix operations
- Metal Performance Shaders for future GPU acceleration
- CryptoKit concepts for secure aggregation
- MetricKit-style performance and energy reporting
- Privacy manifests for platform privacy disclosure
- On-device processing as the default execution model

## Project Structure

```text
PrivacyContextCompressor/
│
├── App/
│   └── PrivacyContextCompressorApp.swift
│
├── Data/
│   └── SystemsKnowledgeBase.swift
│
├── Models/
│   ├── CompressionUseCase.swift
│   ├── PrivacyFeature.swift
│   ├── SystemsDomain.swift
│   ├── SystemsMetric.swift
│   └── SystemsNote.swift
│
├── Resources/
│   └── PrivacyInfo.xcprivacy
│
├── Services/
│   ├── FederatedCompressionTrainer.swift
│   └── PrivacyPreferences.swift
│
├── Views/
│   ├── ContextCompressionDashboardView.swift
│   ├── Components/
│   └── Panels/
│
└── README.md
```

## How To Run

1. Open Xcode.

2. Create a new iOS or macOS SwiftUI app project named:

```text
PrivacyContextCompressor
```

3. Copy the following folders into the Xcode project:

```text
App
Data
Models
Resources
Services
Views
```

4. In Xcode, make sure all Swift files are added to the app target.

5. Make sure `PrivacyInfo.xcprivacy` is included in the app target.

6. Build and run the app using:

```text
Command + R
```

## Recommended Xcode Settings

Use these settings for a clean local run:

```text
Interface: SwiftUI
Language: Swift
Minimum iOS target: iOS 17 or later
Minimum macOS target: macOS 14 or later
```

## Main Files

### App/PrivacyContextCompressorApp.swift

The app entry point. It launches the main dashboard view.

### Views/ContextCompressionDashboardView.swift

The main SwiftUI dashboard. It shows the context compression use case, privacy controls, federated learning simulation, performance metrics, and Apple-native technology map.

### Services/FederatedCompressionTrainer.swift

The local simulator for privacy-preserving federated compression policy learning.

It models:

- Device-local updates
- Update clipping
- Noise injection
- Secure aggregation-style policy updates
- Compression policy recommendation

### Services/PrivacyPreferences.swift

Stores local privacy settings such as:

- Local-only inference
- Telemetry disabled by default
- Sensitive context redaction
- Data minimization
- Export review

### Models/CompressionUseCase.swift

Defines compression samples, policy decisions, and federated round outputs.

### Resources/PrivacyInfo.xcprivacy

Privacy manifest placeholder for Apple platform deployment.

## Example Workflow

1. Launch the app.
2. Review the real-world use case.
3. Inspect modeled context sources.
4. Run the federated compression simulation.
5. Compare compression ratio, latency, quality, and memory pressure.
6. Review the recommended compression policy.
7. Toggle privacy controls and observe how the system is framed around local-first execution.

## Why This Matters

On-device intelligence becomes more useful when it has access to personal context. But personal context is sensitive, large, and expensive to process repeatedly.

Privacy Context Compressor demonstrates one way to think about that systems problem:

- Use compression to make personal context efficient
- Use on-device processing to keep raw data local
- Use federated learning to improve policies without collecting user content
- Use privacy controls to reduce leakage risk
