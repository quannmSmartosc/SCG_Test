//
//  BaseViewController.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

class BaseViewController<T: ViewModelProtocol>: UIViewController, UseViewModel {
    public typealias Model = T
    
    var viewModel: Model?
    var disposeBag = DisposeBag()
    var isLoading: Bool = false
    public var isHiddenTabbar: Bool {
        return false
    }
    
    open func bind(to model: Model) {
        self.viewModel = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.1607843137, green: 0.6431372549, blue: 0.5960784314, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().tintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        styleNavigation()
    }
    
    private func styleNavigation() {
        navigationController?.navigationBar.tintColor = .tintColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .tintColor
        navigationController?.navigationBar.isTranslucent = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor.clear
        appearance.shadowImage = UIImage(color: .clear, size: .zero)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    func bind() {
    }

    func showAlert(_ title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                   style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayError(_ error: Error) {
        showAlert(nil, message: error.localizedDescription)
    }
}
