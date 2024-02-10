//
//  AppDelegate.swift
//  Pokemonium
//
//  Created by Filipe Ramos on 08/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.window?.rootViewController = UINavigationController(rootViewController: UIViewController())
        self.window?.makeKeyAndVisible()

        guard let window = self.window, let navController = window.rootViewController as? UINavigationController else { return true }
        
        self.appCoordinator = AppCoordinator(navController: navController)
        self.appCoordinator?.start()

        return true
    }
}
