//
//  PlaidAPI.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-01.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import Foundation

let host = "https://sandbox.plaid.com"

func getAuth() {
//    let endpoint = "/auth/get"
//    URLSession.shared.dataTask(with: endpoint) { data, res, err in
//
//    }
}

func getAccessToken(clientId: String, secret: String, publicToken: String, completionBlock: @escaping (String, String) -> Void) -> Void {
    let endpoint = "/item/public_token/exchange"
    let url = URL(string: host + endpoint)!
    
    let parameters: [String: Any] = [
        "client_id": clientId,
        "secret":  secret,
        "public_token": publicToken
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        return
    }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) {(data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                guard let dictionary = json else {return}
                let accessToken = dictionary["access_token"] ?? ""
                let itemId = dictionary["item_id"] ?? ""
                completionBlock(accessToken, itemId)
            } catch {
                print(error)
            }
        }
    }.resume()
}

func getAccountBalance(accessToken: String, secret: String, clientId: String, completionBlock: @escaping (AccountBalance) -> Void) {
    let endpoint = "/accounts/balance/get"
    let url = URL(string: host + endpoint)!
    
    let parameters: [String: Any] = [
        "client_id": clientId,
        "secret":  secret,
        "access_token": accessToken
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        return
    }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) {(data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                let accountBalance = try JSONDecoder().decode(AccountBalance.self, from: data)
                completionBlock(accountBalance)
            } catch {
                print(error)
            }
        }
    }.resume()
}

func getTransactions(accessToken: String, numDays: Int = 30, options: Any?, completionBlock: @escaping ((TransactionResponse) -> Void)) {
    let endpoint = "/transactions/get"
    let url = URL(string: host + endpoint)!
    
    let currentDate = Date()
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    let endDate = dateFormatterGet.string(from: currentDate)
    
    let startDate1 = Calendar.current.date(byAdding: .day, value: -numDays, to: currentDate)
    guard let startDate = startDate1 else {return}
    let startDateFormatted = dateFormatterGet.string(from: startDate)
    
    var parameters: [String: Any?] = [
        "access_token": accessToken,
        "secret":  Constants.SECRET,
        "client_id": Constants.CLIENT_ID,
        "start_date": startDateFormatted,
        "end_date": endDate,
    ]
    if options != nil {
        parameters["options"] = options
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
        return
    }
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) {(data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                let transactionResponse = try JSONDecoder().decode(TransactionResponse.self, from: data)
                completionBlock(transactionResponse)
            } catch {
                print(error)
            }
        }
    }.resume()
}
