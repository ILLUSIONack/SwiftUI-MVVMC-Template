import XCTest
@testable import CBSearchApp

final class ProductServiceTests: XCTestCase {
    func test_search_whenSuccess_shouldReturnProduct() async throws {
        // Given
        let environment = Environment()
        let sut = environment.createSUT()
        
        // When
        let result = try await sut.search(by: "Test", page: 1)
        
        // Then
        XCTAssertEqual(result.products.first?.productName, "Apple iPhone 6 32GB Grijs")
        XCTAssertEqual(result.pageCount, 1)
        XCTAssertEqual(result.totalResults, 1)
        XCTAssertEqual(result.pageSize, 1)
    }
    
    func test_search_whenFailure_shouldThrowError() async throws {
        // Given
        var environment = Environment()
        environment.mockAPIService = MockAPIService(shouldThrowError: true)
        let sut = environment.createSUT()

        // When
        do {
            _ = try await sut.search(by: "Test", page: 1)
            XCTFail("Expected error, but got success")
        } catch {
        // Then
            XCTAssertNotNil(error)
        }
    }
    
    private struct Environment {
        var mockAPIService = MockAPIService(shouldThrowError: false)
        
        func createSUT() -> ProductService {
            ProductService(apiService: mockAPIService)
        }
    }
}
