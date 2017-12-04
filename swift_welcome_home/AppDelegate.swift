//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - Setup
    
    private func setupWindow(rootController: UIViewController) {
        let _window = UIWindow(frame: UIScreen.main.bounds)
        _window.rootViewController = rootController
        _window.makeKeyAndVisible()
        window = _window
    }
    
    // MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow(rootController: ScreensFactory.homesController(manager: HomesManager()))
        
        return true
    }
}
