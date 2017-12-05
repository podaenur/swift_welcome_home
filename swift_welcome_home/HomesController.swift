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
    
    typealias HomesControllerHome = (name: String, isPrimary: Bool)
    
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
    
    // MARK: - Actions
    
    @IBAction func onAddNew(_ sender: Any) {
        let controller = UIAlertController(title: "New home", message: "Enter name of new home", preferredStyle: .alert)
        
        controller.addTextField {
            (textField) in
            textField.placeholder = "Enter home name"
        }
        
        let save = UIAlertAction(title: "Save home", style: .default) {
            [weak self] (_) in
            guard let name = controller.textFields?.first?.text else {
                print("Empty name handling here...")
                return
            }
            self?.manager?.addHome(name: name)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        controller.addAction(save)
        controller.addAction(cancel)
        
        present(controller, animated: true)
    }
    
    // MARK: - Setup
    
    private func setup(_ table: UITableView) {
        table.dataSource = self
        table.delegate = self
        
        table.rowHeight = UITableViewAutomaticDimension
    }
    
    private func bindManager() {
        manager?.onUpdateHomes = {
            [weak self] in
            guard let sSelf = self else { return }
            
            guard let _manager = sSelf.manager else { return }
            sSelf.homeNames = _manager.homes.map({ ($0.name, $0.isPrimary) })
            sSelf.tableView.reloadData()
            sSelf.updateEmptyStateUI()
        }
    }
    
    // MARK: - Private
    
    private func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let model = homeNames[indexPath.row]
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.isPrimary ? "Primary" : nil
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let home = homeNames[indexPath.row]
        
        let updatePrimary = UITableViewRowAction(style: .normal, title: "Set primary") {
            (_, _) in
            self.manager?.setHomeAsPrimary(at: indexPath)
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Remove") {
            (_, _) in
            self.manager?.removeHome(at: indexPath)
        }
        
        return home.isPrimary ? [deleteAction] : [deleteAction, updatePrimary]
    }
}
