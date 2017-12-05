//
//  Created by Evgeniy Akhmerov on 04/12/2017.
//  Copyright © 2017 Evgeniy Akhmerov. All rights reserved.
//

import UIKit

class HomesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Definitions
    
    private struct Consts {
        static let homesCellIdent = "cell"
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noHomesLabel: UILabel!
    
    // MARK: - Properties
    
    private var homeNames = [HomesControllerHome]()
    var manager: HomesManager? {
        didSet {
            bindManager()
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(tableView)
        updateEmptyStateUI()
    }
    
    // MARK: - Setup
    
    private func setup(_ table: UITableView) {
        table.dataSource = self
        //  table.delegate = self
        
        table.rowHeight = UITableViewAutomaticDimension
    }
    
    private func bindManager() {
        manager?.onUpdateHomes = {
            [weak self] in
        }
    }
    
    // MARK: - Private
    
    private func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let model = viewModel.items[indexPath.row]
        cell.textLabel?.text = model
    }
    
    private func updateEmptyStateUI() {
        let hasData = homeNames.count > 0
        tableView.isHidden = !hasData
        noHomesLabel.isHidden = hasData
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Consts.homesCellIdent, for: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    
}
