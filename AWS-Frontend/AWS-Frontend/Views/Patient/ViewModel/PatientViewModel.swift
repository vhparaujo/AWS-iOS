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
    var patients: [Patient] = []
    
    func getPatients() async throws {
        do {
            let fetchedPatients: [Patient] = try await service.getData(from: "https://3se393o3y1.execute-api.us-east-1.amazonaws.com/dev/patients")
           
            Task { @MainActor in
                patients = fetchedPatients
            }
        }
        catch {
            print(error)
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
    
}
