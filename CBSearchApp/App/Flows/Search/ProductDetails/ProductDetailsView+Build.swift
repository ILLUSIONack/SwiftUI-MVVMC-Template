import Foundation

extension ProductDetailsView {
    static func build(
        product: Product,
		delegate: MainFlowCoordinatorDelegate
    ) -> ProductDetailsView {
        let viewModel = ProductDetailsView.ViewModel(product: product)
		viewModel.delegate = delegate
        return ProductDetailsView(viewModel: viewModel)
    }
}
