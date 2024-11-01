//
//  ContentView.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            PatientsView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [PatientClass.self, AddressClass.self])
}
