//
//  PatientCreateView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI

struct PatientCreateView: View {
    
    @Environment(PatientViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var taxId: String = ""
    //    @State var birthDate: String = ""
    @State var weight: Double?
    @State var height: Double?
    @State var bloodType: String = ""
    @State var healthServiceNumber: String = ""
    @State var country: String = ""
    @State var state: String = ""
    @State var city: String = ""
    @State var street: String = ""
    @State var postalCode: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("Cadastrar Paciente")
                    .font(.title)
                    .bold()
                
                TextField("Nome", text: $name)
                    .textFieldStyle(.roundedBorder)
                TextField("Telefone", text: $phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.phonePad)
                TextField("CPF", text: $taxId)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                //                TextField("Birth Date", text: $birthDate)
                //                    .textFieldStyle(.roundedBorder)
                TextField("Peso (kg)", value: $weight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Altura (m)", value: $height, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Tipo sanguíneo", text: $bloodType)
                    .textFieldStyle(.roundedBorder)
                TextField("Número do SUS", text: $healthServiceNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("País", text: $country)
                    .textFieldStyle(.roundedBorder)
                TextField("Estado", text: $state)
                    .textFieldStyle(.roundedBorder)
                TextField("Cidade", text: $city)
                    .textFieldStyle(.roundedBorder)
                TextField("Rua", text: $street)
                    .textFieldStyle(.roundedBorder)
                TextField("CEP", text: $postalCode)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            try await viewModel.createPatient(patient:
                                                                Patient(id: nil, name: name, phoneNumber: phoneNumber, taxId: taxId, weight: weight ?? 0, height: height ?? 0, bloodType: bloodType, healthServiceNumber: healthServiceNumber, address:
                                                                            Address(country: country, state: state, city: city, street: street, postalCode: postalCode)
                                                                       )
                            )
                            dismiss()
                        } catch {
                            print("Erro ao obter pacientes: \(error.localizedDescription)")
                        }
                    }
                    
                } label: {
                    Text("Criar paciente")
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

#Preview {
    let viewModel = PatientViewModel()
    PatientCreateView()
        .environment(viewModel)
}
