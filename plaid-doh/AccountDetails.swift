//
//  AccountDetails.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-06.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct AccountDetails: View {
    let accessToken: String
    var account: Account
    @State var transactions: [Transaction]? = nil

    var body: some View {
        GeometryReader { metrics in
            VStack(alignment: .leading, spacing: 0) {
                List {
                    HStack {
                        Text("Current balance:")
                        Spacer()
                        Text("$" + String(format: "%.2f", self.account.balances.current))
                    }
                    HStack {
                        Text("Available balance:")
                        Spacer()
                        Text("$" + String(format: "%.2f", self.account.balances.available ?? 0.00 ))
                    }
                    HStack {
                        Text("Type:")
                        Spacer()
                        Text(self.account.type)
                    }
                }.navigationBarTitle(Text(self.account.name))
                    .listStyle(GroupedListStyle())
                    .frame(height: (metrics.size.height)*0.2)
                           
                if(self.transactions != nil) {
                    TransactionList(accessToken: self.accessToken, transactions: self.transactions!)
                }
                Spacer()
            }
        }.onAppear() {
            self.loadTransactions()
        }
    }
    
    func loadTransactions() {
        let options: [String: Any] = [
            "account_ids": [account.account_id],
            "count": 100,
            "offset": 0
        ]
        getTransactions(accessToken: accessToken, options: options) { (transactionResponse) in
            self.transactions = transactionResponse.transactions
        }
    }
}

