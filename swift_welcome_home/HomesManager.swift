//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import HomeKit

class HomesManager: NSObject, HMHomeManagerDelegate {
    
    // MARK: - Properties
    
    private let innerManager = HMHomeManager()
    private(set) var homes = [HMHome]()
    
    var tmp_onUpdateHomes: (() -> Void)?
    
    // MARK: - Life cycle
    
    override init() {
        super.init()
        self.innerManager.delegate = self
    }
    
    // MARK: - Private
    
    private func onUpdateHomes() {
        tmp_onUpdateHomes?()
    }
    
    // MARK: - HMHomeManagerDelegate
    
    func homeManager(_ manager: HMHomeManager, didAdd home: HMHome) {
        print(#function)
        homes = manager.homes
        onUpdateHomes()
    }
    
    func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
        print(#function)
        homes = manager.homes
        onUpdateHomes()
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print(#function)
        homes = manager.homes
        onUpdateHomes()
    }
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        print(#function)
    }
}
