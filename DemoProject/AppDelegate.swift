//
//  AppDelegate.swift
//  DemoProject
//
//  Created by Subhangi Pawar on 13/12/20.
//

import UIKit
import Firebase
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        createMenuView()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    //MARk:- Create Menu
    fileprivate func createMenuView() {
        // create viewController code...
        let storyBoard   = UIStoryboard(name: "Main", bundle:nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController")
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        var nvc = UINavigationController()
        if UserDefaults.standard.bool(forKey: defaultsKeys.keepSignedIn) {
            nvc = UINavigationController(rootViewController: mainViewController)
        }
        else{
            nvc = UINavigationController(rootViewController: loginViewController)
        }
        // nvc = UINavigationController(rootViewController: loginViewController)
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        let leftViewController = storyBoard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        //           slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
        
    }


}
