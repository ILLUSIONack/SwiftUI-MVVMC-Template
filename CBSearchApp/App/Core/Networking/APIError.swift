import Foundation

enum APIError: LocalizedError {
    case clientError(Int)
    case serverError(Int)
    case unknown
    case coruptURL

    var errorDescription: String? {
        switch self {
        case .clientError(let code):
            return "Client error with status code: \(code)"
        case .serverError(let code):
            return "Server error with status code: \(code)"
        case .unknown:
            return "An unknown error occurred"
        case .coruptURL:
            return "The url is corupt or invalid"
        }
    }
}
