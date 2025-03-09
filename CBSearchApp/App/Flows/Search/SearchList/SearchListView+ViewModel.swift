import Foundation

@MainActor
protocol SearchListViewModelProtocol: ObservableObject {
    func searchProducts(query: String)
    func loadNextPageIfNeeded(currentProduct product: Product)
    func performedAction(action: UserAction)
}

extension SearchListView {
    final class ViewModel: SearchListViewModelProtocol {
        @Published var viewState: ViewState = ViewState()
        
        var navigationTitle: String = "Products"
        private let productService: ProductServiceProtocol
        private var task: Task<Void, Error>?
        
        private var currentPage = 1
        
		weak var delegate: MainFlowCoordinatorDelegate?

		init(productService: ProductServiceProtocol) {
            self.productService = productService
        }
        
        func searchProducts(query: String) {
            viewState.searchText = query
            resetSearch()

			task?.cancel()
			task = Task {
				await fetchPage()
			}
        }
        
        func loadNextPageIfNeeded(currentProduct product: Product) {
            guard viewState.hasMorePages else { return }
            if product == viewState.products.last {
                currentPage += 1
				task?.cancel()
				task = Task {
					await fetchPage()
				}
            }
        }
        
        func fetchPage() async {
            if viewState.searchText.isEmpty {
                viewState.state = .noResults
                return
            }
            guard viewState.hasMorePages else { return }
            do {
                guard !Task.isCancelled else { return }
                let response = try await productService.search(by: viewState.searchText, page: currentPage)
                viewState.products.append(contentsOf: response.products)
                viewState.hasMorePages = response.totalResults - response.pageSize * currentPage > 0
                viewState.state = response.products.isEmpty ? .noResults : .loaded(products: viewState.products)
			} catch let error as NSError {
				guard error.code != NSURLErrorCancelled else { return }
                viewState.state = .error
            }
        }
        
        private func resetSearch() {
            currentPage = 1
            viewState.products = []
            viewState.hasMorePages = true
        }
        
        // MARK: - Delegate
        func performedAction(action: UserAction) {
            delegate?.performedAction(action: action)
        }
    }
}
