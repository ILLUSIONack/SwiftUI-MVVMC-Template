import Foundation

enum APIEndPoint {
    case search(query: String, page: Int)

    var url: URL? {
        switch self {
        case .search(let query, let page):
            var components = URLComponents()
            components.scheme = "https"
            components.host = Environment.baseURLHost
            components.path = "/mobile-assignment/search"
            components.queryItems = [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            return components.url
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .GET
        }
    }
    
    enum Environment {
        static let baseURLHost = "bdk0sta2n0.execute-api.eu-west-1.amazonaws.com"
    }
}

