//
//  Address.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation

struct Address: Hashable, Codable {
    let country: String
    let state: String
    let city: String
    let street: String
    let postalCode: String
}
