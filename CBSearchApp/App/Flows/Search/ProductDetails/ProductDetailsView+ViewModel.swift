import Foundation

@MainActor
protocol ProductDetailsViewModelProtocol: ObservableObject, AnyObject {
    func backButtonTapped()
}

extension ProductDetailsView {
    final class ViewModel: ProductDetailsViewModelProtocol {
        @Published var product: Product
		weak var delegate: MainFlowCoordinatorDelegate?

		init (product: Product) {
            self.product = product
        }
        
        func backButtonTapped() {
            delegate?.pop()
        }
    }
}
