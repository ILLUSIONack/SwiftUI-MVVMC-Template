import SwiftUI

struct ProductItemView: View {
    private let product: Product
    
    enum Constants {
        static let imageHeight: CGFloat = 80
    }
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                productImage
                    .frame(width: Constants.imageHeight, height: Constants.imageHeight)
                VStack(alignment: .leading, spacing: 8) {
                    productName
                    usps
                    price
                }
                .accessibilityElement(children: .combine)
                Spacer()
            }
            Spacer()
            Divider()
        }
        .frame(maxWidth: .infinity)
        .accessibilityRespondsToUserInteraction(true)
    }
    
    @ViewBuilder
    private var productImage: some View {
        if let url = product.productImage {
            AsyncImage(url: url, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.imageHeight, height: Constants.imageHeight, alignment: .center)
                    .clipped()
            }, placeholder: {
                ProgressView()
            })
            .accessibilityHidden(true)
        }
    }
    
    @ViewBuilder
    private var productName: some View {
        if let productName = product.productName {
            Text(productName)
                .font(.title3)
                .foregroundColor(Color.black)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    @ViewBuilder
    private var usps: some View {
        if let usps = product.usps {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(usps, id: \.self) { usp in
                    Text("◦ \(usp)")
                        .font(.body)
                        .foregroundColor(Color.black)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
    
    @ViewBuilder
    private var price: some View {
        if let price = product.formattedPrice {
            Text(price)
                .font(.callout)
                .foregroundColor(Color.accentColor)
                .fontWeight(.bold)
        }
    }
}

#Preview(traits: .fixedLayout(width: 250, height: 300)) {
    ProductItemView(product: Product.stub)
}
