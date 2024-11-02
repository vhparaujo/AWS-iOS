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
//    let birthDate: String
    var weight: Double
    var height: Double
    var bloodType: String
    var healthServiceNumber: String
    var address: Address

    func formatStringDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
    
    func formatDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Define o fuso horário para UTC
        
        guard let date = formatStringDate(string: stringDate) else {
           return ""
        }
        return dateFormatter.string(from: date)
    }
    
}

@Model
class PatientClass {
    var id: String?
    var name: String
    var phoneNumber: String
    var taxId: String
//    let birthDate: String
    var weight: Double
    var height: Double
    var bloodType: String
    var healthServiceNumber: String
    @Relationship(deleteRule: .cascade) var address: AddressClass

    init(id: String? = nil, name: String, phoneNumber: String, taxId: String, weight: Double, height: Double, bloodType: String, healthServiceNumber: String, address: AddressClass) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.taxId = taxId
        self.weight = weight
        self.height = height
        self.bloodType = bloodType
        self.healthServiceNumber = healthServiceNumber
        self.address = address
    }

    func formatStringDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
    
    func formatDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // Define o fuso horário para UTC
        
        guard let date = formatStringDate(string: stringDate) else {
           return ""
        }
        return dateFormatter.string(from: date)
    }
    
}
