import XCTest
@testable import CBSearchApp

final class MockProductService: ProductServiceProtocol {
    private let shouldThrowError: Bool
    private let mockProducts: [Product]
    private let totalResults: Int
    private let pageSize: Int
    
    init(
        shouldThrowError: Bool = false,
        mockProducts: [Product] = [],
        totalResults: Int = 0,
        pageSize:Int = 10
    ) {
        self.shouldThrowError = shouldThrowError
        self.mockProducts = mockProducts
        self.totalResults = totalResults
        self.pageSize = pageSize
    }

    func search(by query: String, page: Int) async throws -> ProductsPage {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: -1, userInfo: nil)
        } else {
            return ProductsPage.stub
        }
    }
}
