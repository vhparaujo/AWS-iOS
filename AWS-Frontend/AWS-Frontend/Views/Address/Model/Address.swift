//
//  Address.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation

struct Address: Hashable, Codable {
    var country: String
    var state: String
    var city: String
    var street: String
    var postalCode: String
}
