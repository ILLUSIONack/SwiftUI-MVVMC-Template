import SwiftUI

@main
struct CBSearchApp: App {
	@StateObject private var viewModel = MainFlowCoordinator(container: DependencyContainer())

	var body: some Scene {
		WindowGroup {
			NavigationStack(path: $viewModel.path) {
				viewModel.start()
					.navigationDestination(for: PageAction.self, destination: { pageAction in
						viewModel.buildView(forPageAction: pageAction)
					})
			}
		}
	}
}
