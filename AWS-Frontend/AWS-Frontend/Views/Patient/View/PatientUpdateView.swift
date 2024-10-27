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

    let patient: Patient
    
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
                
                Text("Atualizar Paciente")
                    .font(.title)
                    .bold()
                
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.phonePad)
                TextField("CPF", text: $taxId)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                //                TextField("Birth Date", text: $birthDate)
                //                    .textFieldStyle(.roundedBorder)
                TextField("Weight (kg)", value: $weight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Height (m)", value: $height, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                TextField("Blood Type", text: $bloodType)
                    .textFieldStyle(.roundedBorder)
                TextField("Health Service Number", text: $healthServiceNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("Country", text: $country)
                    .textFieldStyle(.roundedBorder)
                TextField("State", text: $state)
                    .textFieldStyle(.roundedBorder)
                TextField("City", text: $city)
                    .textFieldStyle(.roundedBorder)
                TextField("Street", text: $street)
                    .textFieldStyle(.roundedBorder)
                TextField("Postal Code", text: $postalCode)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                Button {
                    Task {
                        do {
                            try await viewModel.updatePatient(id: patient.id ?? "", patient:
                                                                Patient(id: nil, name: name, phoneNumber: phoneNumber, taxId: taxId, weight: weight ?? 0, height: height ?? 0, bloodType: bloodType, healthServiceNumber: healthServiceNumber, address:
                                                                            Address(country: country, state: state, city: city, street: street, postalCode: postalCode)
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
                    self.name = patient.name
                    self.phoneNumber = patient.phoneNumber
                    self.taxId = patient.taxId
                    self.weight = patient.weight
                    self.height = patient.height
                    self.bloodType = patient.bloodType
                    self.healthServiceNumber = patient.healthServiceNumber
                    self.country = patient.address.country
                    self.state = patient.address.state
                    self.city = patient.address.city
                    self.street = patient.address.street
                    self.postalCode = patient.address.postalCode
                }

        }
        .scrollDismissesKeyboard(.interactively)

    }
    
}

#Preview {
    let exampleAddress = Address(country: "Brasil", state: "Distrito Federal", city: "Gama", street: "olhos dagua", postalCode: "72432-122")
    let examplePatient = Patient(id: "3334093uufnucncienfn", name: "Victor Hugo Pacheco Araujo", phoneNumber: "11999999999", taxId: "12345678901234", weight: 70, height: 180, bloodType: "O+", healthServiceNumber: "1393394", address: exampleAddress)
    PatientUpdateView(patient: examplePatient)
        .environment(PatientViewModel())
}
