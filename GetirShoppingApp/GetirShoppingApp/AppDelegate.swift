//
//  AppDelegate.swift
//  GetirShoppingApp
//
//  Created by Enes Pusa on 9.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = ViewController() // Your initial view controller.
//        window.makeKeyAndVisible()
//        self.window = window
//        UINavigationBar.appearance().barTintColor = UIColor(red: 93/255, green: 62/255, blue: 188/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor(named: "getir-color")
        
        UINavigationBar.appearance().isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "getir-color")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance


        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

