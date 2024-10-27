//
//  PatientsView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI

struct PatientsView: View {
    @StateObject var viewModel = PatientViewModel()
    
    var body: some View {
        VStack {
            
            Text("Lista de Pacientes")
                .font(.title)
            
            List(viewModel.patients, id: \.self) { patient in
                NavigationLink(destination: PatientDetailView(patient: patient)
                    .environmentObject(viewModel)
                ) {
                    Text(patient.name)
                }
            }
            .listStyle(.plain)
        }
        
        .task {
            
            do {
                try await viewModel.getPatients()
            } catch {
                print("Erro ao obter pacientes: \(error.localizedDescription)")
            }
            
        }
        
        
    }
}

#Preview {
    PatientsView()
}
