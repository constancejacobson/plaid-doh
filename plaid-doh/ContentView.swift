//
//  ContentView.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-01.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings
    @State var accessToken = ""
    @State var accountBalance: AccountBalance? = nil
    
    var body: some View {
        if(self.accessToken != "" && self.accountBalance == nil) {
            getAccountBalance(accessToken: self.accessToken, secret: Constants.SECRET, clientId: Constants.CLIENT_ID) { (accountBalance) in
                self.accountBalance = accountBalance
            }
        }
        return VStack {
            if (self.accountBalance != nil) {
                AccountList(accessToken: accessToken, accountBalance: self.accountBalance)
            } else {
                Text("Hey bitch")
                LinkKitView(accessToken: $accessToken, publicKey: Constants.PUBLIC_KEY)
            }
        }.onAppear {
            self.accessToken = UserDefaults.standard.string(forKey: "plaid-access-token") ?? ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
