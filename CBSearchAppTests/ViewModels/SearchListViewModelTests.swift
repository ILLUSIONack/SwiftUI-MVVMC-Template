import XCTest
@testable import CBSearchApp

@MainActor
final class SearchListViewModelTests: XCTestCase {
    func test_onAppear_whenInitialState_shouldBeInitialState() async throws {
        // Given
        let environment = Environment()
        let sut = environment.createSUT()

        // When
        let viewState = sut.viewState
        
        // Then
        XCTAssertTrue(viewState.products.isEmpty)
        XCTAssertTrue(viewState.hasMorePages)
        XCTAssertEqual(viewState.state, .noResults)
    }

    func test_searchProducts_whenSuccess_shouldReturnProducts() async throws {
        // Given
        var environment = Environment()
        environment.mockProductService = MockProductService(mockProducts: [Product.stub])
        let sut = environment.createSUT()

        // When
		sut.viewState.searchText = "test"
		await sut.fetchPage()

		// Then
        XCTAssertEqual(sut.viewState.products.count, 3)
        XCTAssertEqual(sut.viewState.products.first?.productName, "Apple iPhone 6 32GB Grijs")
		XCTAssertEqual(sut.viewState.state, .loaded(products: sut.viewState.products))
    }
    
    func test_searchProducts_whenFailure_shouldBeErrorViewState() async throws {
        // Given
        var environment = Environment()
        environment.mockProductService = MockProductService(shouldThrowError: true)
        let sut = environment.createSUT()
        
        // When
		sut.viewState.searchText = "test"
		await sut.fetchPage()
        
        // Then
        XCTAssertEqual(sut.viewState.state, .error)
    }

    func test_performedAction_whenCalled_shouldCallDelegate() async throws {
        // Given
        let environment = Environment()
        let sut = environment.createSUT()
        
        // When
        sut.performedAction(action: .productDetailsTapped(product: Product.stub))
        
        // Then
        XCTAssertTrue(environment.mockCoordinatorDelegate.getDidPerformActionValue())
    }

	@MainActor
    private struct Environment {
        var mockProductService = MockProductService()
        var mockCoordinatorDelegate = MokcMainFlowCoordinatorDelegate()

		func createSUT() -> SearchListView.ViewModel {
			let viewModel = SearchListView.ViewModel(productService: mockProductService)
			viewModel.delegate = mockCoordinatorDelegate
			return viewModel
		}
    }
}
