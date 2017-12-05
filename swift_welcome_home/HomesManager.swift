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
    
    func setHomeAsPrimary(name: String) {
        let home = homes.first { $0.name.contains(name) }
        guard let toPrimary = home else { return }
        
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
    
    func removeHome(name: String) {
        let first = homes.first { $0.name.lowercased().contains(name.lowercased()) }
        guard let toDelete = first else { return }
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
        print(#function)
        onUpdateHomes?()
    }
    
    func homeManager(_ manager: HMHomeManager, didRemove home: HMHome) {
        print(#function)
        onUpdateHomes?()
    }
    
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        print(#function)
        onUpdateHomes?()
    }
    
    func homeManagerDidUpdatePrimaryHome(_ manager: HMHomeManager) {
        print(#function)
        onUpdateHomes?()
    }
}
