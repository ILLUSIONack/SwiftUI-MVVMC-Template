import Foundation

protocol APIServiceProtocol: Sendable {
    func executeObjectRequest<T: Decodable>(
        _ endPoint: APIEndPoint,
        decodingType: T.Type
    ) async throws -> T
}

final class APIService: APIServiceProtocol, Sendable {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func executeObjectRequest<T: Decodable>(
        _ endPoint: APIEndPoint,
        decodingType: T.Type
    ) async throws -> T {
        guard let url = endPoint.url else {
            throw APIError.coruptURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        let validData = try handleResponse(data, response: response)
        return try decoder.decode(T.self, from: validData)
    }
    
    private func handleResponse(_ data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 400...499:
            throw APIError.clientError(httpResponse.statusCode)
        case 500...599:
            throw APIError.serverError(httpResponse.statusCode)
        default:
            throw APIError.unknown
        }
    }
}
