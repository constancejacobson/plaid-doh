//
//  Models.swift
//  plaid-doh
//
//  Created by Constance Jacobson on 2020-07-06.
//  Copyright © 2020 Constance Jacobson. All rights reserved.
//

import Foundation

struct ItemError: Decodable {
    let error_type: String
    let error_code: String
    let error_message: String
    let display_message: String?
}

struct Item: Decodable {
    let item_id: String
    let institution_id: String?
    let webhook: String?
    let error: ItemError?
    let available_products: [String]
    let billed_products: [String]
    let consent_expiration_time: String?
}

struct Balance: Decodable {
    let available: Double?
    let current: Double
    let limit: Double?
    let iso_currency_code: String?
    let unofficial_currency_code: String?
}

struct Account: Decodable {
    let account_id: String
    let balances: Balance
    let mask: String
    let name: String
    let official_name: String?
    let subtype: String
    let type: String
}

struct AccountBalance: Decodable {
    let accounts: [Account]
    let item: Item
    let request_id: String
}

struct Location: Decodable {
    let address: String?
    let city: String?
    let region: String?
    let postal_code: String?
    let country: String?
    let lat: Int?
    let lon: Int?
    let store_number: String?
}

struct PaymentMeta: Decodable {
    let reference_number: String?
    let ppd_id: String?
    let payee: String?
}

struct Transaction: Decodable {
    let transaction_id: String
    let account_id: String
    let category: [String]?
    let category_id: String?
    let transaction_type: String
    let name: String
    let merchant_name: String?
    let amount: Double
    let iso_currency_code: String?
    let unofficial_currency_code: String?
    let date: String
    let authorized_date: String?
    let location: Location
    let payment_meta: PaymentMeta
    let payment_channel: String
    let pending: Bool
    let pending_transaction_id: String?
    let account_owner: String?
    let transaction_code: String?
}

struct TransactionResponse: Decodable {
    let accounts: [Account]?
    let transactions: [Transaction]
    let item: Item
    let total_transactions: Int
    let request_id: String
}
