import XCTest
@testable import CBSearchApp

final class MockAPIService: APIServiceProtocol {
    private let shouldThrowError: Bool
    
    init(shouldThrowError: Bool = false) {
        self.shouldThrowError = shouldThrowError
    }
    
    func executeObjectRequest<T: Decodable>(
        _ endPoint: APIEndPoint,
        decodingType: T.Type
    ) async throws -> T where T: Decodable {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: -1, userInfo: nil)
        }
        
        let mockResponse = ProductsPage.stub
        return mockResponse as! T
    }
}
