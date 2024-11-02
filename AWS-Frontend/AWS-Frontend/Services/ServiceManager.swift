//
//  PatientsData.swift
//  AWS-Frontend
//
//  Created by Victor Hugo Pacheco Araujo on 26/10/24.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    
    func createData <T:Encodable>(to urlString: String, with data: T) async throws {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(data)
            request.httpBody = jsonData
        } catch {
            print("Error Encoding: \(error.localizedDescription)")
            throw error
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid Response")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Server Response: \(responseString)")
            }
        } catch {
            print("Request Error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func getData <T:Decodable>(from urlString: String) async throws -> T  {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Invalid Response getting data")
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding data to get: \(error)")
            throw error
        }
    }
    
    func updateData<T: Encodable>(to urlString: String, with data: T, using method: String) async throws {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method //"PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let jsonData = try encoder.encode(data)
            request.httpBody = jsonData
        } catch {
            print("Error encoding in update: \(error.localizedDescription)")
            throw error
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid Response updating")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Server Response in update: \(responseString)")
            }
        } catch {
            print("Request Error updating: \(error.localizedDescription)")
            throw error
        }
    }
    
    func deleteData(from urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid Response deleting data")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Server Response deleting: \(responseString)")
            }
        } catch {
            print("Request Error deleting: \(error.localizedDescription)")
            throw error
        }
    }
    
}
