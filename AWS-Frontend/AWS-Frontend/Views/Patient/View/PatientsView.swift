//
//  PatientsView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI

struct PatientsView: View {
    @State var viewModel = PatientViewModel()
    
    var body: some View {
        VStack {
          
            List(viewModel.patients, id: \.self) { patient in
                NavigationLink(destination: PatientDetailView(patient: patient)
                    .environment(viewModel)
                ) {
                    Text(patient.name)
                }
            }
            .listStyle(.plain)
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
            do {
                try await viewModel.getPatients()
            } catch {
                print("Erro ao obter pacientes: \(error.localizedDescription)")
            }
        }
        
        .refreshable {
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
