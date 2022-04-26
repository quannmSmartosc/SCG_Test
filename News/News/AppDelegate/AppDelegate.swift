//
//  AppDelegate.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    var launchCoordinator = LaunchCoordinator()
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let window = self.window {
            launchCoordinator.setRoot(for: window)
        }
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            HeadlineRepository() as HeadlineUseCase
        }
        register {
            #if DEBUG
            DevApi() as ApiConfiguration
            #else
            ProdApi() as ApiConfiguration
            #endif
        }.scope(.application)
    }
}

