//
//  AppDelegate.swift
//  MovieApp
//
//  Created by LeeX on 7/8/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var data = DataModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nowPlayingNavigationController = storyboard.instantiateViewController(withIdentifier: "MoviesNavigationController") as! UINavigationController
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! MyMoviesViewController
        nowPlayingViewController.endpoint = "now_playing"
        nowPlayingNavigationController.title = "Now Playing"
        nowPlayingNavigationController.tabBarItem.image = UIImage(named: "play_icon")
        
        
        let topRatedNavigationController = storyboard.instantiateViewController(withIdentifier: "MoviesNavigationController") as! UINavigationController
        let topRatedViewController = topRatedNavigationController.topViewController as! MyMoviesViewController
        topRatedViewController.endpoint = "top_rated"
        topRatedNavigationController.title = "Top Rated"
        topRatedNavigationController.tabBarItem.image = UIImage(named: "star_icon")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [nowPlayingNavigationController, topRatedNavigationController]
        window?.rootViewController = tabBarController
        tabBarController.tabBar.tintColor = UIColor.darkText
        tabBarController.tabBar.barTintColor = UIColor.orange.withAlphaComponent(0.2)
        tabBarController.tabBar.unselectedItemTintColor = UIColor.darkGray.withAlphaComponent(0.7)
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

