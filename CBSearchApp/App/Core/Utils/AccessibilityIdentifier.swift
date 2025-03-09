import Foundation

struct AccessibilityIdentifier {
    enum SearchList {
        static let errorView = "searchlist_error_view"
        static let noResultsView = "searchlist_no_results_view"
        static let productItem = "searchlist_product_item"
        static let productListItemButton = "searchlist_product_item_button"
        static let navigationBarTitle = "Products"
        static let scrollView = "ScrollView"
        static let searchTextFieldText = "Search Products"
        static let searchCancelButtonText = "Cancel"
    }
    
    enum ProductDetails {
        static let detailsView = "productDetails_view"
    }
}
