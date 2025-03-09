import Foundation

extension SearchListView {
    static func build(
        container: DependencyContainerProtocol,
        delegate: MainFlowCoordinatorDelegate
    ) -> SearchListView {
        let productService = container.resolveProductService()
        let viewModel = SearchListView.ViewModel(
            productService: productService
        )
		viewModel.delegate = delegate

        return SearchListView(viewModel: viewModel)
    }
}
