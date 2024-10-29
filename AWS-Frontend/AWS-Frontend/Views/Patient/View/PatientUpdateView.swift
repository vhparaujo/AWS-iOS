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

    @Binding var patient: Patient
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Atualizar Paciente")
                    .font(.title)
                    .bold()
                
                TextField("Name", text: $patient.name)
                    .textFieldStyle(.roundedBorder)
                TextField("Phone Number", text: $patient.phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.phonePad)
                TextField("CPF", text: $patient.taxId)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                //                TextField("Birth Date", text: $birthDate)
                //                    .textFieldStyle(.roundedBorder)
                TextField("Weight (kg)", value: $patient.weight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Height (m)", value: $patient.height, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Blood Type", text: $patient.bloodType)
                    .textFieldStyle(.roundedBorder)
                TextField("Health Service Number", text: $patient.healthServiceNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("Country", text: $patient.address.country)
                    .textFieldStyle(.roundedBorder)
                TextField("State", text: $patient.address.state)
                    .textFieldStyle(.roundedBorder)
                TextField("City", text: $patient.address.city)
                    .textFieldStyle(.roundedBorder)
                TextField("Street", text: $patient.address.street)
                    .textFieldStyle(.roundedBorder)
                TextField("Postal Code", text: $patient.address.postalCode)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            try await viewModel.updatePatient(
                                id: patient.id ?? "", patient:
                                        Patient(
                                            id: nil,
                                            name: patient.name,
                                            phoneNumber: patient.phoneNumber,
                                            taxId: patient.taxId,
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
            

        }
        .scrollDismissesKeyboard(.interactively)

    }
    
}

//#Preview {
//    let exampleAddress = Address(country: "Brasil", state: "Distrito Federal", city: "Gama", street: "olhos dagua", postalCode: "72432-122")
//    let examplePatient = Patient(id: "3334093uufnucncienfn", name: "Victor Hugo Pacheco Araujo", phoneNumber: "11999999999", taxId: "12345678901234", weight: 70, height: 180, bloodType: "O+", healthServiceNumber: "1393394", address: exampleAddress)
//    PatientUpdateView(patient: examplePatient)
//        .environment(PatientViewModel())
//}
