//
//  TransactionList.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-07.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct TransactionList: View {
    let accessToken: String
    let transactions: [Transaction]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.transactions, id: \.transaction_id) { (transaction) in
                    NavigationLink(destination: TransactionDetails(transaction: transaction)) {
                        HStack {
                            Text(transaction.name)
                            Spacer()
                            Text("$" + String(format: "%.2f", transaction.amount))
                        }
                    }
                    
                }
            }.navigationBarTitle(Text("Transactions"))
            .listStyle(GroupedListStyle())
        }
        
    }
}

