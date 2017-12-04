//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import Foundation

class HomesViewModel: HomesViewModeling {
    
    // MARK: - HomesViewModeling
    
    var items: [String] {
        let str = "Fusce Fringilla Dapibus Lorem Purus"
        return str.components(separatedBy: " ")
    }
}
