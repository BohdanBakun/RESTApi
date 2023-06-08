//
//  DataManager.swift
//  RESTApiTask
//
//  Created by Богдан Бакун on 01.06.2023.
//

import RealmSwift

struct DataManager {
    
    // MARK: - Realm
    
    private let realm = try? Realm()
    
    func savePurchase(_ purchaseName: String) {
        
        let purchase = Purchase()
        purchase.name = purchaseName
        
        try? realm?.write {
            realm?.add(purchase)
        }
    }
    
    func deletePurchase(_ purchase: Purchase) {
        
        try? realm?.write {
            realm?.delete(purchase)
        }
    }
    
    func getPurchases() -> [Purchase] {
        
        var purchases: [Purchase] = []

        guard
            let purchasesResult = realm?.objects(Purchase.self)
        else { return [] }

        purchasesResult.forEach {
            purchases.append($0)
        }

        return purchases
    }
}
