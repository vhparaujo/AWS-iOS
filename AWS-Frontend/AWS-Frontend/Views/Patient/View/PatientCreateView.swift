//
//  PatientCreateView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI

struct PatientCreateView: View {
    
    @EnvironmentObject var viewModel: PatientViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var taxId: String = ""
//    @State var birthDate: String = ""
    @State var weight: Int?
    @State var height: Int?
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
                    .keyboardType(.numberPad)
                TextField("Height (cm)", value: $height, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("Blood Type", text: $bloodType)
                    .textFieldStyle(.roundedBorder)
                TextField("Health Service Number", text: $healthServiceNumber)
                    .textFieldStyle(.roundedBorder)
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
                            try await viewModel.createPatient(patient: Patient(id: nil, name: name, phoneNumber: phoneNumber, taxId: taxId, weight: weight ?? 0, height: height ?? 0, bloodType: bloodType, healthServiceNumber: healthServiceNumber, address: Address(country: country, state: state, city: city, street: street, postalCode: postalCode)))
                        } catch {
                            print("Erro ao obter pacientes: \(error.localizedDescription)")
                        }
                    }
                    
                    dismiss()
                } label: {
                    Text("Create")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }.padding(.vertical)
                
            }.padding()
        }
        
    }
}

#Preview {
    PatientCreateView()
}
