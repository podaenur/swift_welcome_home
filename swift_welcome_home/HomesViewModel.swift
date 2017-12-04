//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

class HomesViewModel: HomesViewModeling {
    
    // MARK: - Properties
    
    private let manager: HomesManager
    private var homeNames = [String]()
    
    // MARK: - Life cycle
    
    init(manager: HomesManager) {
        self.manager = manager
        
        self.manager.tmp_onUpdateHomes = {
            [weak self] in
            self?.homeNames = manager.homes.map({ $0.name })
        }
    }
    
    // MARK: - HomesViewModeling
    
    var items: [String] {
        return homeNames
    }
}
