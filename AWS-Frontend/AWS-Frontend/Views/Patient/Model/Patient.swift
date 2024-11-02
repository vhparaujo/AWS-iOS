//
//  Patient.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation
import SwiftData

struct Patient: Hashable, Codable {
    var id: String?
    var name: String
    var phoneNumber: String
    var taxId: String
    var birthDate: String
    var weight: Double
    var height: Double
    var bloodType: String
    var healthServiceNumber: String
    var address: Address
}

@Model
class PatientClass {
    var id: String?
    var name: String
    var phoneNumber: String
    var taxId: String
    var birthDate: String
    var weight: Double
    var height: Double
    var bloodType: String
    var healthServiceNumber: String
    @Relationship(deleteRule: .cascade) var address: AddressClass

    init(id: String? = nil, name: String, phoneNumber: String, taxId: String, birthDate: String, weight: Double, height: Double, bloodType: String, healthServiceNumber: String, address: AddressClass) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.taxId = taxId
        self.birthDate = birthDate
        self.weight = weight
        self.height = height
        self.bloodType = bloodType
        self.healthServiceNumber = healthServiceNumber
        self.address = address
    } 
}
