//
//  PlkPlaidLinkPicker.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-02.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import SwiftUI
import LinkKit

struct PlkPlaidLinkPicker: UIViewControllerRepresentable {
    class Coordinator : NSObject, PLKPlaidLinkViewDelegate, UINavigationControllerDelegate {
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didSucceedWithPublicToken publicToken: String, metadata: [String : Any]?) {
            parent.didFinish(publicToken)
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func linkViewController(_ linkViewController: PLKPlaidLinkViewController, didExitWithError error: Error?, metadata: [String : Any]?) {
            print(error?.localizedDescription ?? "error")
            parent.didFinish(nil)
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        var parent: PlkPlaidLinkPicker
        
        init(_ parent: PlkPlaidLinkPicker) {
            self.parent = parent
        }
    }
    
    let publicKey: String
    let didFinish: (String?) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 2.
    func makeUIViewController(context: Context) -> PLKPlaidLinkViewController {
        let linkConfiguration = PLKConfiguration(key: self.publicKey, env: .sandbox, product: .auth)
        linkConfiguration.clientName = Constants.CLIENT_ID
        return PLKPlaidLinkViewController(configuration: linkConfiguration, delegate: context.coordinator);
    }
    
    // 3.
    func updateUIViewController(_ uiViewController: PLKPlaidLinkViewController, context: Context) {
        
    }
}
