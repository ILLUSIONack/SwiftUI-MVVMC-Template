import Foundation

struct Product: Codable, Sendable {
    let productId: Int
    let productName: String?
    let reviewInformation: ReviewInformation?
    let usps: [String]?
    let availabilityState: Int?
    let salesPriceIncVat: Double?
    let productImage: URL?
    let coolbluesChoiceInformationTitle: String?
    let promoIcon: PromoIcon?
    let nextDayDelivery: Bool
    
    var formattedPrice: String? {
        guard let salesPriceIncVat else { return nil }
        return String(salesPriceIncVat).toCurrency()
    }
    enum CodingKeys: String, CodingKey {
        case usps = "USPs"
        case productId, productName, reviewInformation, availabilityState,
             salesPriceIncVat, productImage, coolbluesChoiceInformationTitle,
             promoIcon, nextDayDelivery
    }
}

extension Product: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(productId)
    }
        
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId
    }
}
