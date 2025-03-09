import Foundation

protocol ProductServiceProtocol: Sendable {
    func search(by query: String, page: Int) async throws -> ProductsPage
}

final class ProductService: ProductServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func search(by query: String, page: Int) async throws -> ProductsPage {
        try await apiService.executeObjectRequest(
            .search(query: query, page: page),
            decodingType: ProductsPage.self
        )
    }
}
