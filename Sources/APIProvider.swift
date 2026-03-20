import Foundation

// MARK: - API Provider

enum APIProvider: String, CaseIterable, Identifiable, Codable {
    case groq
    case openai
    case togetherAI = "together_ai"
    case fireworks
    case nvidia
    case custom

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .groq: return "Groq"
        case .openai: return "OpenAI"
        case .togetherAI: return "Together AI"
        case .fireworks: return "Fireworks"
        case .nvidia: return "NVIDIA NIM"
        case .custom: return "Custom"
        }
    }

    var defaultBaseURL: String {
        switch self {
        case .groq: return "https://api.groq.com/openai/v1"
        case .openai: return "https://api.openai.com/v1"
        case .togetherAI: return "https://api.together.xyz/v1"
        case .fireworks: return "https://audio-prod.api.fireworks.ai/v1"
        case .nvidia: return "https://integrate.api.nvidia.com/v1"
        case .custom: return ""
        }
    }

    var availableTranscriptionModels: [TranscriptionModel] {
        switch self {
        case .groq:
            return [
                TranscriptionModel(
                    id: "whisper-large-v3",
                    displayName: "Whisper Large V3",
                    description: "Default. Highest accuracy, best for detailed transcription."
                ),
                TranscriptionModel(
                    id: "whisper-large-v3-turbo",
                    displayName: "Whisper Large V3 Turbo",
                    description: "Faster and cheaper. Slightly less accurate but great for most use cases."
                ),
            ]
        case .openai:
            return [
                TranscriptionModel(
                    id: "whisper-1",
                    displayName: "Whisper 1",
                    description: "Default. OpenAI's general-purpose speech recognition model."
                ),
                TranscriptionModel(
                    id: "gpt-4o-transcribe",
                    displayName: "GPT-4o Transcribe",
                    description: "Higher accuracy using GPT-4o. Better at handling accents and noisy audio."
                ),
                TranscriptionModel(
                    id: "gpt-4o-mini-transcribe",
                    displayName: "GPT-4o Mini Transcribe",
                    description: "Cheaper GPT-4o variant. Good balance of cost and quality."
                ),
            ]
        case .togetherAI:
            return [
                TranscriptionModel(
                    id: "openai/whisper-large-v3",
                    displayName: "Whisper Large V3",
                    description: "Default. High accuracy Whisper model hosted on Together AI."
                ),
                TranscriptionModel(
                    id: "openai/whisper-large-v3-turbo",
                    displayName: "Whisper Large V3 Turbo",
                    description: "Faster variant with slightly reduced accuracy."
                ),
                TranscriptionModel(
                    id: "deepgram/deepgram-nova-3",
                    displayName: "Deepgram Nova 3",
                    description: "Deepgram's latest model. Optimized for real-time, low-latency transcription."
                ),
                TranscriptionModel(
                    id: "nvidia/parakeet-tdt-0.6b-v3",
                    displayName: "NVIDIA Parakeet",
                    description: "Lightweight 0.6B parameter model. Very fast with good English accuracy."
                ),
            ]
        case .fireworks:
            return [
                TranscriptionModel(
                    id: "whisper-v3",
                    displayName: "Whisper V3",
                    description: "Default. Full Whisper V3 model for highest accuracy."
                ),
                TranscriptionModel(
                    id: "whisper-v3-turbo",
                    displayName: "Whisper V3 Turbo",
                    description: "Faster variant. Good for shorter recordings where speed matters."
                ),
            ]
        case .nvidia:
            return [
                TranscriptionModel(
                    id: "openai/whisper-large-v3",
                    displayName: "Whisper Large V3",
                    description: "Default. Whisper Large V3 running on NVIDIA GPU infrastructure."
                ),
            ]
        case .custom:
            return [
                TranscriptionModel(
                    id: "whisper-large-v3",
                    displayName: "Whisper Large V3",
                    description: "Default. Common model ID for OpenAI-compatible endpoints."
                ),
                TranscriptionModel(
                    id: "whisper-large-v3-turbo",
                    displayName: "Whisper Large V3 Turbo",
                    description: "Faster variant. Common model ID for OpenAI-compatible endpoints."
                ),
            ]
        }
    }

    var availableChatModels: [ChatModel] {
        switch self {
        case .groq:
            return [
                ChatModel(
                    id: "meta-llama/llama-4-scout-17b-16e-instruct",
                    displayName: "Llama 4 Scout 17B",
                    description: "Default. Fast and capable model with vision support for context analysis."
                ),
            ]
        case .openai:
            return [
                ChatModel(
                    id: "gpt-4o-mini",
                    displayName: "GPT-4o Mini",
                    description: "Default. Fast and affordable. Great for post-processing transcriptions."
                ),
                ChatModel(
                    id: "gpt-4o",
                    displayName: "GPT-4o",
                    description: "Most capable. Better at complex context but slower and more expensive."
                ),
            ]
        case .togetherAI:
            return [
                ChatModel(
                    id: "meta-llama/Llama-3.3-70B-Instruct-Turbo",
                    displayName: "Llama 3.3 70B Turbo",
                    description: "Default. High quality with fast inference. Best for accurate post-processing."
                ),
                ChatModel(
                    id: "meta-llama/Meta-Llama-3.1-8B-Instruct-Turbo",
                    displayName: "Llama 3.1 8B Turbo",
                    description: "Smaller and faster. Good enough for simple dictation cleanup."
                ),
            ]
        case .fireworks:
            return [
                ChatModel(
                    id: "accounts/fireworks/models/llama-v3p3-70b-instruct",
                    displayName: "Llama 3.3 70B",
                    description: "Default. High quality Llama model on Fireworks infrastructure."
                ),
            ]
        case .nvidia:
            return [
                ChatModel(
                    id: "meta/llama-3.1-8b-instruct",
                    displayName: "Llama 3.1 8B",
                    description: "Default. Lightweight model running on NVIDIA GPU infrastructure."
                ),
            ]
        case .custom:
            return [
                ChatModel(
                    id: "meta-llama/llama-4-scout-17b-16e-instruct",
                    displayName: "Llama 4 Scout 17B",
                    description: "Default. Common model ID for OpenAI-compatible endpoints."
                ),
            ]
        }
    }

    var defaultTranscriptionModel: TranscriptionModel {
        availableTranscriptionModels.first!
    }

    var defaultChatModel: ChatModel {
        availableChatModels.first!
    }

    var apiKeyStorageKey: String {
        switch self {
        case .groq: return "groq_api_key"
        case .openai: return "openai_api_key"
        case .togetherAI: return "together_api_key"
        case .fireworks: return "fireworks_api_key"
        case .nvidia: return "nvidia_api_key"
        case .custom: return "custom_api_key"
        }
    }

    var apiKeyPlaceholder: String {
        switch self {
        case .groq: return "Paste your Groq API key"
        case .openai: return "Paste your OpenAI API key"
        case .togetherAI: return "Paste your Together AI API key"
        case .fireworks: return "Paste your Fireworks API key"
        case .nvidia: return "Paste your NVIDIA API key"
        case .custom: return "Paste your API key"
        }
    }

    var keyInstructionURL: URL? {
        switch self {
        case .groq: return URL(string: "https://console.groq.com/keys")
        case .openai: return URL(string: "https://platform.openai.com/api-keys")
        case .togetherAI: return URL(string: "https://api.together.ai/settings/api-keys")
        case .fireworks: return URL(string: "https://fireworks.ai/account/api-keys")
        case .nvidia: return URL(string: "https://build.nvidia.com/")
        case .custom: return nil
        }
    }

    var keyInstructionDisplayURL: String {
        switch self {
        case .groq: return "console.groq.com/keys"
        case .openai: return "platform.openai.com/api-keys"
        case .togetherAI: return "api.together.ai/settings/api-keys"
        case .fireworks: return "fireworks.ai/account/api-keys"
        case .nvidia: return "build.nvidia.com"
        case .custom: return ""
        }
    }
}

// MARK: - Model Types

struct TranscriptionModel: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let displayName: String
    var description: String = ""

    /// Sentinel value representing a user-entered custom model ID
    static let customPlaceholder = TranscriptionModel(
        id: "__custom__",
        displayName: "Custom",
        description: "Enter your own model ID."
    )

    var isCustom: Bool { id == "__custom__" }
}

struct ChatModel: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let displayName: String
    var description: String = ""

    /// Sentinel value representing a user-entered custom model ID
    static let customPlaceholder = ChatModel(
        id: "__custom__",
        displayName: "Custom",
        description: "Enter your own model ID."
    )

    var isCustom: Bool { id == "__custom__" }
}
