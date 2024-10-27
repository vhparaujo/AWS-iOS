//
//  Patient.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation

struct Patient: Hashable, Codable {
    let id: String?
    let name: String
    let phoneNumber: String
    let taxId: String
//    let birthDate: String
    let weight: Int
    let height: Int
    let bloodType: String
    let healthServiceNumber: String
    let address: Address

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
