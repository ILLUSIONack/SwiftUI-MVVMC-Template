import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let name = viewModel.product.productName {
                Text(name)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
            }
            if let availabilityState = viewModel.product.availabilityState {
                Text(String(availabilityState))
                    .font(.title)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back Button") {
                    viewModel.backButtonTapped()
                }
            }
        })
        .padding()
        .navigationTitle(viewModel.product.productName ?? "")
        .accessibilityIdentifier(AccessibilityIdentifier.ProductDetails.detailsView)
    }
}
