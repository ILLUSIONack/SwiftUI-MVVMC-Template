import SwiftUI
import Foundation

struct SearchListView: View {
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    enum Constants {
        static let imageHeight: CGFloat = 48.0
        static let listTopPadding: CGFloat = 16.0
        static let noResultsImageName: String = "magnifyingglass.circle.fill"
        static let errorImageName: String = "exclamationmark.warninglight.fill"
        static let searchPrompt: String = "Search Products"
        static let noResultsText: String = "Try searching for a product"
        static let errorText: String = "An Error has occured while fetching products"
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState.state {
            case .error:
                errorView
            case .noResults:
                noResultsView
            case .loaded(let products):
                content(products)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
			text: $viewModel.viewState.searchText,
			placement: .navigationBarDrawer(displayMode: .always),
			prompt: Constants.searchPrompt
		)
        .onChange(of: viewModel.viewState.searchText) { _, text in
            viewModel.searchProducts(query: text)
        }
    }
    
    private func content(_ products: [Product]) ->some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(products, id: \.productId) { product in
                    productItemView(product)
                }
            }
        }
        .accessibilityIdentifier(AccessibilityIdentifier.SearchList.scrollView)
    }
    
    private var noResultsView: some View {
        VStack(alignment: .center) {
            Image(systemName: Constants.noResultsImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.imageHeight, height: Constants.imageHeight)
                .accessibilityHidden(true)
            Text(Constants.noResultsText)
                .multilineTextAlignment(.center)
                .font(.title3)
                .foregroundColor(Color.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityIdentifier(AccessibilityIdentifier.SearchList.noResultsView)
    }
    
    private var errorView: some View {
        VStack(alignment: .center) {
            Image(systemName: Constants.errorImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.imageHeight, height: Constants.imageHeight)
                .accessibilityHidden(true)
            Text(Constants.errorText)
                .multilineTextAlignment(.center)
                .font(.title2)
                .foregroundColor(Color.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityIdentifier(AccessibilityIdentifier.SearchList.errorView)
    }
    
    private func productItemView(_ product: Product) -> some View {
        Button {
            viewModel.performedAction(action: .productDetailsTapped(product: product))
        } label: {
            ProductItemView(product: product)
                .background(Color.white)
                .onAppear {
                    viewModel.loadNextPageIfNeeded(currentProduct: product)
                }
                .accessibilityIdentifier(AccessibilityIdentifier.SearchList.productItem)
        }
        .buttonStyle(.plain)
        .padding(.top, Constants.listTopPadding)
        .accessibilityIdentifier(AccessibilityIdentifier.SearchList.productListItemButton)
    }
}
