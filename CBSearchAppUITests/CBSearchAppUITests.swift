import XCTest
@testable import CBSearchApp

final class CBSearchAppUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        
        XCUIDevice.shared.orientation = .portrait
        
        app.launch()
    }

    func test_appStart_searchTextField() throws {
        checkNoResultsViewVisible()
        checkSearchTextFieldExistsAndTap()
        typeTestInSearchTextFieldAndCheckCancelButtonExists()
        checkProductListItemsExistsAndSwipeAndTap()
    }
    
    private func checkNoResultsViewVisible() {
        XCTAssertTrue(noResultsView.exists)
    }
    
    private func checkSearchTextFieldExistsAndTap() {
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
    }
    
    private func typeTestInSearchTextFieldAndCheckCancelButtonExists() {
        searchTextField.typeText("Test")
        XCTAssertTrue(searchCancelButton.exists)
    }
    
    private func checkProductListItemsExistsAndSwipeAndTap() {
        XCTAssertTrue(searchListItem.waitForExistence(timeout: 2.0))
        XCTAssertTrue(searchListItemButton.waitForExistence(timeout: 2.0))
        scrollView.swipeDown()
        scrollView.swipeDown()
        
        XCTAssertTrue(searchListItemButton.isHittable)
        searchListItemButton.tap()
    }
}

extension CBSearchAppUITests {
    
    var scrollView: XCUIElement {
        app.scrollViews[AccessibilityIdentifier.SearchList.scrollView]
    }
        
    var productNavigationBar: XCUIElement {
        app.navigationBars[AccessibilityIdentifier.SearchList.navigationBarTitle]
    }
    
    var searchTextField: XCUIElement {
        app.searchFields[AccessibilityIdentifier.SearchList.searchTextFieldText]
    }
    
    var searchCancelButton: XCUIElement {
        productNavigationBar.buttons[AccessibilityIdentifier.SearchList.searchCancelButtonText]
    }
    
    var noResultsView: XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifier.SearchList.noResultsView]
    }
    
    var errorView: XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifier.SearchList.errorView]
    }
    
    var searchListItem: XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifier.SearchList.productItem]
    }
    
    var searchListItemButton: XCUIElement {
        app.descendants(matching: .button).matching(identifier: AccessibilityIdentifier.SearchList.productListItemButton).firstMatch
    }
    
    var productDetailsView: XCUIElement {
        app.descendants(matching: .any)[ AccessibilityIdentifier.ProductDetails.detailsView]
    }
}

