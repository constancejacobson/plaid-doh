//
//  AccountsListView.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-06.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct AccountList: View {
    let accessToken: String
    @State var accountBalance: AccountBalance? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.accountBalance!.accounts, id: \.account_id) { (account) in
                    NavigationLink(destination: AccountDetails(accessToken: self.accessToken, account: account)) {
                        HStack {
                           Text(account.name)
                           Spacer()
                           Text(String(format: "%.2f", account.balances.current))
                       }
                    }
                }
                .navigationBarTitle(Text("Accounts"))
            }
            .navigationBarItems(trailing: NavigationLink(destination: BudgetDetails(accessToken: accessToken)) {
                Text("Budget")
            })
        }
        
    }
}

struct AccountList_Previews: PreviewProvider {
    static let accessToken: String = ""
    static var previews: some View {
        AccountList(accessToken: accessToken, accountBalance: nil)
    }
}
