import Foundation

extension ProductsPage {
    static var stub: ProductsPage {
        ProductsPage(
            products: [
                Product.stub,
                Product.stub,
                Product.stub
            ],
            currentPage: 1,
            pageSize: 1,
            totalResults: 1,
            pageCount: 1
        )
    }
}

extension Product {
    static var stub: Product {
        Product(productId: 785359,
                productName: "Apple iPhone 6 32GB Grijs",
                reviewInformation:
                    ReviewInformation(
                        reviews: [],
                        reviewSummary:
                            ReviewSummary(
                                reviewAverage: 9.1,
                                reviewCount: 952
                            )
                    ),
                usps: ["32 GB opslagcapaciteit", "4,7 inch Retina HD scherm", "iOS 11"],
                availabilityState: 2,
                salesPriceIncVat: 369,
                productImage: URL(string: "https://image.coolblue.nl/300x750/products/818870"),
                coolbluesChoiceInformationTitle: "middenklasse iPhone",
                promoIcon:  PromoIcon(text: "middenklasse iPhone", type: "coolblues-choice"),
                nextDayDelivery: true
        )
    }
}
