//
//  AppCoordinator.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import XCoordinator

class AppCoordinator: NavigationCoordinator<AppRoute> {
    
    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .pop(let animation):
            return .pop(animation: animation)
        case .details(let article):
            let detailsViewModel = ArticleDetailsViewModel(with: weakRouter, articleData: article)
            let viewController = ArticleDetailsViewController.initFromNib()
            viewController.bind(to: detailsViewModel)
            return .push(viewController)
        case .home:
            let homeViewModel = HomeViewModel(with: weakRouter)
            let viewController = HomeViewController.initFromNib()
            viewController.bind(to: homeViewModel)
            return .push(viewController)
        }
    }
}
