//
//  PatientViewModel.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation
import Observation

@Observable
class PatientViewModel {
    @ObservationIgnored let service = ServiceManager.shared
    //    var patients: [Patient] = []
    
    func getPatients() async throws -> [Patient] {
        do {
            let fetchedPatients: [Patient] = try await service.getData(from: "https://3se393o3y1.execute-api.us-east-1.amazonaws.com/dev/patients")
            
            //            Task { @MainActor in
            //                patients = fetchedPatients
            //            }
            return fetchedPatients
        }
        catch {
            print(error)
            return []
        }
    }
    
    func deletePatients(id: String) async throws {
        do {
            try await service.deleteData(from: "https://3se393o3y1.execute-api.us-east-1.amazonaws.com/dev/patients/\(id)")
        }
        catch {
            print(error)
        }
    }
    
    func createPatient(patient: Patient) async throws {
        do {
            try await service.createData(to: "https://3se393o3y1.execute-api.us-east-1.amazonaws.com/dev/patients", with: patient)
        } catch {
            print(error)
        }
    }
    
    func updatePatient(id: String, patient: Patient) async throws {
        do {
            try await service.updateData(to: "https://3se393o3y1.execute-api.us-east-1.amazonaws.com/dev/patients/\(id)", with: patient, using: "PATCH")
        } catch {
            print(error)
        }
    }
    
    func formatDateForISO(birthDate: Date) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        dateFormatter.timeZone = .current
        let birthDateString = dateFormatter.string(from: birthDate)
        return birthDateString
    }
    
    func formatStringDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
    
    func formatDate(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current // Define o fuso horário para UTC
        
        guard let date = formatStringDate(string: stringDate) else {
            return ""
        }
        return dateFormatter.string(from: date)
    }
    
}
