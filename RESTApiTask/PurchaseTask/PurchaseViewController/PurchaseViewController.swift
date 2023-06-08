//
//  PurchaseViewController.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 01.06.2023.
//

import UIKit

class PurchaseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var purchases: [Purchase] = []
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My purchases"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PurchaseCell")
        
        purchases = self.dataManager.getPurchases()
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(
            title: "Purchase",
            message: "Add a new purchase",
            preferredStyle: .alert
        )
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            
            guard
                let textField = alert.textFields?.first,
                let purchaseToSave = textField.text
            else { return }
            
            self.dataManager.savePurchase(purchaseToSave)
            
            self.purchases = self.dataManager.getPurchases()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

extension PurchaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell"),
            indexPath.row < purchases.count
        else { return UITableViewCell() }
        
        let purchase = purchases[indexPath.row]
        var config = cell.defaultContentConfiguration()
        
        config.text = purchase.name
        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let purchase = purchases[indexPath.row]
            
            dataManager.deletePurchase(purchase)
            
            purchases.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
