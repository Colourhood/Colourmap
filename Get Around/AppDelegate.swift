//
//  AppDelegate.swift
//  Get Around
//
//  Created by Andrei Villasana on 4/12/18.
//  Copyright © 2018 Andrei Villasana. All rights reserved.
//

import UIKit

let store = DataStore()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationService = LocationService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        locationService.getLocationPermission()
        return true
    }
}

