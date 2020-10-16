//
//  AppDelegate.swift
//  KobayashiMaru
//
//  Created by Jordan Bryant on 10/16/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PersonController.shared.loadFromPersistentStore()
        
        return true
    }
    
}

