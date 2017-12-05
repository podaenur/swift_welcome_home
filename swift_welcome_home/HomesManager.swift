//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import HomeKit

class HomesManager: NSObject, HMHomeManagerDelegate {
    
    // MARK: - Properties
    
    private let innerManager = HMHomeManager()
    var homes: [HMHome] {
        return innerManager.homes
    }
    
    var onUpdateHomes: (() -> Void)?
    
    // MARK: - Life cycle
    
    override init() {
        super.init()
        self.innerManager.delegate = self
    }
    
    // MARK: - Public
    
    func addHome(name: String) {
        precondition(!name.isEmpty)
        
        innerManager.addHome(withName: name) {
            [weak self] (_, error) in
            if let _error = error {
                print(_error)
            } else {
                guard let sSelf = self else { return }
                
                sSelf.onUpdateHomes?()
            }
        }
    }
    
    func setHomeAsPrimary(at indexPath: IndexPath) {
        let toPrimary = homes[indexPath.row]
        
        innerManager.updatePrimaryHome(toPrimary) {
            [weak self] (error) in
            if let _error = error {
                print(_error)
            } else {
                guard let sSelf = self else { return }
                
                sSelf.onUpdateHomes?()
            }
        }
    }
    
    func removeHome(at indexPath: IndexPath) {
        let toDelete = homes[indexPath.row]
        
        innerManager.removeHome(toDelete) {
            [weak self] (error) in
            if let _error = error {
                print(_error)
            } else {
                guard let sSelf = self else { return }
                
                sSelf.onUpdateHomes?()
            }
        }
    }
    
    // MARK: - HMHomeManagerDelegate
    
    func homeManager(_ manager: HMHomeManager, didAdd home: HMHome) {
        onUpdateHomes?()
    }
    
    func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
        onUpdateHomes?()
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        onUpdateHomes?()
    }
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        onUpdateHomes?()
    }
}
