import Foundation

protocol DependencyContainerProtocol {
    func resolveProductService() -> ProductServiceProtocol
}

final class DependencyContainer: DependencyContainerProtocol {
    private let productService: ProductServiceProtocol
    private let apiSerice: APIServiceProtocol
    
    init() {
        self.apiSerice = APIService()
        self.productService = ProductService(apiService: apiSerice)
    }
    
    func resolveProductService() -> ProductServiceProtocol {
        productService
    }
}
