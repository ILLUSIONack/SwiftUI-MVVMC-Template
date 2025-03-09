import SwiftUI

@MainActor
protocol MainFlowCoordinatorDelegate: AnyObject {
	func performedAction(action: UserAction)
	func pop()
}

@MainActor
protocol MainFlowCoordinatorProtocol: ObservableObject {
	associatedtype view: View
	func start() -> view
	func getProductDetailsView(product: Product) -> ProductDetailsView
}

final class MainFlowCoordinator: MainFlowCoordinatorProtocol, MainFlowCoordinatorDelegate {
	@Published var path = NavigationPath()

	private let container: DependencyContainerProtocol

	init(container: DependencyContainerProtocol) {
		self.container = container
	}

	func start() -> some View {
		SearchListView.build(container: container, delegate: self)
	}

	func pop() {
		path.removeLast()
	}

	func performedAction(action: UserAction) {
		switch action {
		case .productDetailsTapped(let product):
			path.append(PageAction.gotoProductDetailsView(product: product))
		}
	}

	func getProductDetailsView(product: Product) -> ProductDetailsView {
		ProductDetailsView.build(product: product, delegate: self)
	}

	func buildView(forPageAction pageAction: PageAction) -> some View {
		switch pageAction {
		case .gotoProductDetailsView(let product):
			getProductDetailsView(product: product)
		}
	}
}

