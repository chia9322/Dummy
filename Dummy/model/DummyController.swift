//
//  DummyController.swift
//  Dummy
//
//  Created by Chia on 2022/05/30.
//

import UIKit

class DummyController {
    
    static let shared = DummyController()
    
    enum DummyControllerError: Error, LocalizedError {
        case userResponseNotFound
        case imageDataMissing
    }
    
    func fetchUsers() async throws -> [User] {
        let baseURL = URL(string: "https://dummyapi.io/data/v1/")
        let userURL = baseURL?.appendingPathComponent("user")
        var userUrlComponent = URLComponents(url: userURL!, resolvingAgainstBaseURL: true)
        userUrlComponent?.queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "limit", value: "50")
        ]
        var request = URLRequest(url: (userUrlComponent?.url)!)
        request.httpMethod = "GET"
        request.addValue(appId, forHTTPHeaderField: "app-id")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DummyControllerError.userResponseNotFound
        }
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(UserResponse.self, from: data)
        
        return userResponse.data
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DummyControllerError.imageDataMissing
        }
        
        guard let image = UIImage(data: data) else {
            throw DummyControllerError.imageDataMissing
        }
        
        return image
    }
    
}
