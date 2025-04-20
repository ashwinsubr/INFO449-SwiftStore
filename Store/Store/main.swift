//
//  main.swift
//  Store
//
//  Created by Ted Neward on 2/29/24.
//

import Foundation

protocol SKU {
    var name: String { get }
    func price() -> Int
}

class Item: SKU {
    let name: String
    private let priceEach: Int
    
    init(name: String, priceEach: Int) {
        self.name = name
        self.priceEach = priceEach
    }
    
    func price() -> Int {
        return priceEach
    }
}

class Receipt {
    private var skuItems: [SKU] = []
    
    func add(_ item: SKU) {
        skuItems.append(item)
    }
    
    func items() -> [SKU] {
        return skuItems
    }
    
    func total() -> Int {
        return skuItems.reduce(0) { $0 + $1.price() }
    }
    
    func output() -> String {
        var result = "Receipt:\n"
        
        for item in skuItems {
            let dollars = Double(item.price()) / 100.0
            result += "\(item.name): $\(String(format: "%.2f", dollars))\n"
        }
        
        result += "------------------\n"
        let totalDollars = Double(total()) / 100.0
        result += "TOTAL: $\(String(format: "%.2f", totalDollars))"
        
        return result
    }
}

class Register {
    private var currentReceipt: Receipt
    
    init() {
        currentReceipt = Receipt()
    }
    
    init(currentReceipt: Receipt) {
        self.currentReceipt = currentReceipt
    }
    
    func scan(_ item: SKU) {
        currentReceipt.add(item)
    }
    
    func subtotal() -> Int {
        return currentReceipt.total()
    }
    
    func total() -> Receipt {
        let completedReceipt = currentReceipt
        currentReceipt = Receipt()
        return completedReceipt
    }
}

class Store {
    let version = "0.1"
    func helloWorld() -> String {
        return "Hello world"
    }
}

