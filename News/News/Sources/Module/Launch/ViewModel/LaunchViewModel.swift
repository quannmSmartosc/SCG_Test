//
//  LaunchViewModel.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import XCoordinator

class LaunchViewModel: NSObject {
    
    let router: WeakRouter<LaunchRoute>
    
    init(router: WeakRouter<LaunchRoute>) {
        self.router = router
    }
}
