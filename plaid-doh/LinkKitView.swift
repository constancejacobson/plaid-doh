//
//  LinkKitView.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-01.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI

struct LinkKitView: View {
    @State private var showingPlaidLink = false
    @Binding var accessToken: String
    
    let publicKey: String
    
    var body: some View {
        Button("Log in") {
            self.showingPlaidLink = true
        }
        .sheet(isPresented: $showingPlaidLink, onDismiss: onDismiss) {
            PlkPlaidLinkPicker(publicKey: self.publicKey) { (publicToken) in
                guard let publicToken = publicToken else {
                    // We failed!
                    print("Linking an account failed")
                    return
                }
                
                // We succeeded
                print("Linking an account succeeded with public token: \(publicToken)")
                
                getAccessToken(clientId: Constants.CLIENT_ID, secret: Constants.SECRET, publicToken: publicToken, completionBlock: self.onComplete)
            }
        }
    }
    
    func onComplete(accessToken: String, itemId: String) {
        print("access token: " + accessToken)
        self.accessToken = accessToken
        UserDefaults.standard.set(accessToken, forKey: "plaid-access-token")
    }
    
    func onDismiss() {
        self.showingPlaidLink = false
    }
}

struct LinkKitView_Previews: PreviewProvider {
    @State static var accessToken = ""
    static var previews: some View {
        LinkKitView(accessToken: $accessToken, publicKey: Constants.PUBLIC_KEY)
    }
}
