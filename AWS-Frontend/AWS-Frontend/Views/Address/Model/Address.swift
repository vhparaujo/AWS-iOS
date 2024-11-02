//
//  Address.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation
import SwiftData

struct Address: Hashable, Codable {
    var country: String
    var state: String
    var city: String
    var street: String
    var postalCode: String
}

@Model
class AddressClass {
    var country: String
    var state: String
    var city: String
    var street: String
    var postalCode: String

    init(country: String, state: String, city: String, street: String, postalCode: String) {
        self.country = country
        self.state = state
        self.city = city
        self.street = street
        self.postalCode = postalCode
    }
}
