//
//  AWS_FrontendApp.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import SwiftData
import SwiftUI

@main
struct AWS_FrontendApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [PatientClass.self, AddressClass.self])
    }
}
