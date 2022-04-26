//
//  LaunchViewController.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit

class LaunchViewController: UIViewController {

    var viewModel: LaunchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            delayThenGotoHome()
    }

    private func delayThenGotoHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.viewModel.router.trigger(.home)
        }
    }
}
