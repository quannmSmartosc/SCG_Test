//
//  LaunchCoordinator.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import XCoordinator

class LaunchCoordinator: ViewCoordinator<LaunchRoute> {
    
    init() {
        let viewController = LaunchViewController.initFromNib()
        super.init(rootViewController: viewController)
        viewController.viewModel = LaunchViewModel(router: weakRouter)
    }
    
    override func prepareTransition(for route: LaunchRoute) -> TransitionType {
        switch route {
        case .home:
            let coordinator = AppCoordinator(initialRoute: .home)
            coordinator.rootViewController.modalPresentationStyle = .fullScreen
            return .presentOnRoot(coordinator)
        }
    }
}
