//
//  Routes.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import XCoordinator
import RxSwift

enum AppRoute: Route {
    case pop(Animation?)
    case details(Article)
    case home
}

enum LaunchRoute: Route {
    case home
}
