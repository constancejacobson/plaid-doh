//
//  BudgetDetails.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-07.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct BudgetDetails: View {
    let accessToken: String
    @State var transactions: [Transaction]? = nil
    @State var totalSpent: Double = 0
    
    var body: some View {
        VStack {
            Text("Total spent this month on Restaurants:")
            Text("$" + String(totalSpent)).padding()
        }.onAppear() {
            self.loadTransactions()
        }
    }
    
    func loadTransactions() {
        getTransactions(accessToken: accessToken, options: nil) { (transactionResponse) in
            self.transactions = transactionResponse.transactions
            self.setTotalSpent(transactions: transactionResponse.transactions)
        }
    }
    
    func setTotalSpent(transactions: [Transaction]) {
        var sum: Double = 0
        for transaction in transactions {
            guard let _category = transaction.category else {
                return
            }
            if _category.contains("Restaurants") {
                sum += transaction.amount
                print(transaction.name)
            }
        }
        self.totalSpent = sum
    }
}
