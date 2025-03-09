import Foundation
@testable import CBSearchApp

final class MokcMainFlowCoordinatorDelegate: MainFlowCoordinatorDelegate {

    private var didPerformAction = false
    private var didPop = false
    private var actionCompletion: (() -> Void)?
	
    init (
        didPerformAction: Bool = false,
        didPop: Bool = false,
        actionCompletion: (() -> Void)? = nil
    ) {
        self.didPerformAction = didPerformAction
        self.didPop = didPop
        self.actionCompletion = actionCompletion
    }
    
    func pop() {
        didPop = true
    }
    
    func performedAction(action: UserAction) {
        didPerformAction = true
        actionCompletion?()
    }
    
    func getDidPerformActionValue() -> Bool {
        return didPerformAction
    }
    
    func getDidPopValue() -> Bool {
        return didPop
    }
}
