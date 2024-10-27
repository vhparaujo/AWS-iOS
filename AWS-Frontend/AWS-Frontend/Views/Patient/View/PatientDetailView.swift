//
//  PatientDetailView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI

struct PatientDetailView: View {
    @EnvironmentObject var viewModel: PatientViewModel
    let patient: Patient
    
    @Environment(\.dismiss) var dismiss
    @State private var showingAlert = false
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Nome: \(patient.name)")
                    .font(.title)
                Text("Telefone: \(patient.phoneNumber)")
                Text("CFP: \(patient.taxId)")
                Text("Data de Nascimento: \(patient.formatDate(stringDate: patient.birthDate))")
                Text("Peso: \(patient.weight, specifier: "%.1f") kg")
                Text("Altura: \(patient.height, specifier: "%.1f") m")
                Text("Tipo Sanguíneo: \(patient.bloodType)")
                Text("Número do Serviço: \(patient.healthServiceNumber)")
                Text("Endereço:")
                    .font(.title2)
                Text("País: \(patient.address.country)")
                Text("Estado: \(patient.address.state)")
                Text("Cidade: \(patient.address.city)")
                Text("Rua: \(patient.address.street)")
                Text("CEP: \(patient.address.postalCode)")
                
            }
            .navigationTitle("Detalhes do Paciente")
            .padding()
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAlert = true // Mostra o alerta ao clicar no botão
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            .alert("Confirmação de Exclusão", isPresented: $showingAlert) {
                Button("Cancelar", role: .cancel) {}
                Button("Excluir", role: .destructive) {
                    Task {
                        do {
                            try await viewModel.deletePatients(id: patient.id)
                            dismiss() // Volta para a PatientsView após a exclusão
                        } catch {
                            print("Erro ao deletar paciente: \(error.localizedDescription)")
                        }
                    }
                }
            } message: {
                Text("Tem certeza de que deseja excluir este paciente?")
            }
            
        }
        
    }
}

#Preview {
    let exampleAddress = Address(country: "Brasil", state: "Distrito Federal", city: "Gama", street: "olhos dagua", postalCode: "72432-122")
    let examplePatient = Patient(id: "3334093uufnucncienfn", name: "Victor Hugo Pacheco Araujo", phoneNumber: "11999999999", taxId: "12345678901234", birthDate: "2024-10-26", weight: 70.0, height: 1.80, bloodType: "O+", healthServiceNumber: "1393394", address: exampleAddress)
    NavigationStack {
        PatientDetailView(patient: examplePatient)
            .environmentObject(PatientViewModel())
    }
}
