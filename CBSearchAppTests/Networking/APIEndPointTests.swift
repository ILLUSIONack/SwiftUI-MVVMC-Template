import XCTest
@testable import CBSearchApp

final class APIEndPointTests: XCTestCase {
    func test_search_whenQueryAndPageSet_shouldMatchExpectedURLAndMethod() {
        // Given
        let environment = Environment()
        let sut = environment.createSUT()
        
        // When
        let expectedURL = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/mobile-assignment/search?query=apple&page=1"
        let method = sut.method
        
        // Then
        XCTAssertEqual(sut.url?.absoluteString, expectedURL, "Incorrect URL")
        XCTAssertEqual(method, .GET, "The HTTP method for search endpoint should be GET.")
    }
    
    private struct Environment {
        func createSUT() -> APIEndPoint {
            APIEndPoint.search(query: "apple", page: 1)
        }
    }
}
