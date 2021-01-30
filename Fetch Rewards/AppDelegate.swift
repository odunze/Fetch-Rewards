//
//  AppDelegate.swift
//  Fetch Rewards
//
//  Created by Lotanna Igwe-Odunze on 1/29/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .white
        
        let eventsViewModel = EventsViewModel()
        let eventsViewController = EventsViewController(viewModel: eventsViewModel)
        window!.rootViewController = UINavigationController(rootViewController: eventsViewController)
        window!.makeKeyAndVisible()
        return true
    }
}
