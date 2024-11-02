//
//  PatientUpdateView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 27/10/24.
//

import SwiftUI

struct PatientUpdateView: View {
    @Environment(PatientViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var patient: PatientClass
    @State var birthDate: Date = .init()
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Atualizar Paciente")
                    .font(.title)
                    .bold()
                
                TextField("Nome", text: $patient.name)
                    .textFieldStyle(.roundedBorder)
                TextField("Telefone", text: $patient.phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.phonePad)
                TextField("CPF", text: $patient.taxId)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                DatePicker("Data de Nascimento", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
                TextField("Peso (kg)", value: $patient.weight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Altura (m)", value: $patient.height, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Tipo sanguíneo", text: $patient.bloodType)
                    .textFieldStyle(.roundedBorder)
                TextField("Numero do SUS", text: $patient.healthServiceNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("País", text: $patient.address.country)
                    .textFieldStyle(.roundedBorder)
                TextField("Estado", text: $patient.address.state)
                    .textFieldStyle(.roundedBorder)
                TextField("Cidade", text: $patient.address.city)
                    .textFieldStyle(.roundedBorder)
                TextField("Rua", text: $patient.address.street)
                    .textFieldStyle(.roundedBorder)
                TextField("CEP", text: $patient.address.postalCode)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            
                            let birthDateString = viewModel.formatDateForISO(birthDate: birthDate)
                            
                            try await viewModel.updatePatient(
                                id: patient.id ?? "", patient:
                                    Patient(
                                        id: nil,
                                        name: patient.name,
                                        phoneNumber: patient.phoneNumber,
                                        taxId: patient.taxId,
                                        birthDate: birthDateString,
                                        weight: patient.weight,
                                        height: patient.height,
                                        bloodType: patient.bloodType,
                                        healthServiceNumber: patient.healthServiceNumber,
                                        address: Address(
                                            country: patient.address.country,
                                            state: patient.address.state,
                                            city: patient.address.city,
                                            street: patient.address.street,
                                            postalCode: patient.address.postalCode
                                        )
                                    )
                            )
                        } catch {
                            print("Erro ao obter pacientes: \(error.localizedDescription)")
                        }
                    }
                    
                    dismiss()
                } label: {
                    Text("Atualizar")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }.padding(.vertical)
                
            }.padding()
            
                .onAppear {
                    self.birthDate = viewModel.formatStringDate(string: patient.birthDate) ?? .now
                }
            
                .onDisappear {
                    patient.birthDate = viewModel.formatDateForISO(birthDate: birthDate)
                }
            
            
        }
        .scrollDismissesKeyboard(.interactively)
        
    }
    
}

#Preview {
    let exampleAddress = AddressClass(country: "Brasil", state: "Distrito Federal", city: "Gama", street: "olhos dagua", postalCode: "72432-122")
    let examplePatient = PatientClass(id: "3334093uufnucncienfn", name: "Victor Hugo Pacheco Araujo", phoneNumber: "11999999999", taxId: "12345678901234", birthDate: "2002/10/30", weight: 70, height: 180, bloodType: "O+", healthServiceNumber: "1393394", address: exampleAddress)
    PatientUpdateView(patient: .constant(examplePatient))
        .environment(PatientViewModel())
}
