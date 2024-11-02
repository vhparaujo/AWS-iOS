//
//  PatientsView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI
import SwiftData

struct PatientsView: View {
    
    @Query private var patients: [PatientClass]
    
    @Environment(\.modelContext) private var context
    
    var viewModel = PatientViewModel()
    
    @AppStorage("lastFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            List(patients, id: \.self) { patient in
                NavigationLink(destination: PatientDetailView(patient: patient)
                    .environment(viewModel)
                ) {
                    Text(patient.name)
                }
            }
            .listStyle(.plain)
            
            Text("\(patients.count)")
        }
        
        .navigationTitle("Lista de Pacientes")
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    PatientCreateView()
                        .environment(viewModel)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.blue)
                }
            }
        }
        
        .task {
            isLoading = true
            defer { isLoading = false }
            if hasExceededLimit() || patients.isEmpty {
                await clearPatients()
                await importData()
            }
        }
        
        .refreshable {
            await clearPatients()
            await importData()
        }
        
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
    }
    
    @MainActor
    private func importData() async {
        do {
            print("Lista de pacientes está vazia. Buscando dados...")
            
            let getPatients = try await viewModel.getPatients()
            
            let patients = getPatients
            
            patients.forEach { patient in
                
                let patientModel = PatientClass(
                    id: patient.id,
                    name: patient.name,
                    phoneNumber: patient.phoneNumber,
                    taxId: patient.taxId,
                    weight: patient.weight,
                    height: patient.height,
                    bloodType: patient.bloodType,
                    healthServiceNumber: patient.healthServiceNumber,
                    address: AddressClass(
                        country: patient.address.country,
                        state: patient.address.state,
                        city: patient.address.city,
                        street: patient.address.street,
                        postalCode: patient.address.postalCode
                    )
                )
                
                context.insert(patientModel)
            }
            lastFetched = Date.now.timeIntervalSince1970
            print(lastFetched)
            
        } catch {
            print("Erro ao obter pacientes: \(error.localizedDescription)")
        }
    }
    
    func hasExceededLimit() -> Bool {
        let timeLimit = 5
        let currentTime = Date.now
        let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
        
        guard let differenceInMinutes = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else { return false
        }
        
        return differenceInMinutes >= timeLimit
    }
    
    @MainActor
    private func clearPatients() async {
        print("Limpando pacientes salvos...")
        for patient in patients {
            context.delete(patient)
        }
        print("Pacientes limpos.")
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [PatientClass.self, AddressClass.self])
}
