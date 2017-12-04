//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

struct ScreensFactory {
    static func homesController(manager: HomesManager) -> UIViewController {
        let controller = UIStoryboard.wh_main.instantiateInitialViewController()
        guard let navigationController = controller as? UINavigationController,
            let homesController = navigationController.viewControllers.first as? HomesController else { fatalError() }
        
        let viewModel = HomesViewModel(manager: manager)
        homesController.viewModel = viewModel
        return homesController
    }
}
