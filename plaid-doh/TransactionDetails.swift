//
//  TransactionDetails.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-06.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct TransactionDetails: View {
    var transaction: Transaction? = nil
    
    var body: some View {
        guard let _transaction = transaction else {
            return AnyView(Text("No transaction details"))
        }
        
        return AnyView(VStack {
            Text(_transaction.name)
            Text(_transaction.transaction_type)
            Text(_transaction.amount.description)
            Spacer()
            Text(_transaction.date)
        })
    }
}

struct TransactionDetails_Previews: PreviewProvider {
    static let transaction: Transaction? = nil
    static var previews: some View {
        TransactionDetails(transaction: transaction)
    }
}
