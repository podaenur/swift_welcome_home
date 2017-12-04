//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

protocol HomesViewModeling {
    var items: [String] { get }
}

class HomesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Definitions
    
    private struct Consts {
        static let homesCellIdent = "cell"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: HomesViewModeling!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(tableView)
    }
    
    // MARK: - Setup
    
    private func setup(_ table: UITableView) {
        table.dataSource = self
        //  table.delegate = self
        
        table.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Private
    
    private func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let model = viewModel.items[indexPath.row]
        cell.textLabel?.text = model
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Consts.homesCellIdent, for: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    
}
