//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import HomeKit

class HomesManager: NSObject, HMHomeManagerDelegate {
    
    // MARK: - Properties
    
    private let innerManager = HMHomeManager()
    
    // MARK: - Public
    
    func activate() {
        innerManager.delegate = self
    }
    
    // MARK: - HMHomeManagerDelegate
    
    func homeManager(_ manager: HMHomeManager, didAdd home: HMHome) {
        print(#function)
    }
    
    func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
        print(#function)
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print(#function)
    }
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        print(#function)
    }
}
