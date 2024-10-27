//
//  PatientViewModel.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation

class PatientViewModel: ObservableObject {
    let service = ServiceManager.shared
    @Published var patients: [Patient] = []
    
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
    
    
    
    
}
