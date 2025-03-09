import Foundation

struct ProductsPage: Codable, Sendable {
    let products: [Product]
    let currentPage: Int
    let pageSize: Int
    let totalResults: Int
    let pageCount: Int
}
