import Foundation

extension SearchListView {
    struct ViewState {
        var state: State = .noResults
        var hasMorePages: Bool = true
        var searchText: String = ""
        var products: [Product] = []
    }
    
    enum State: Equatable {
        case loaded(products: [Product])
        case noResults
        case error
    }
}
