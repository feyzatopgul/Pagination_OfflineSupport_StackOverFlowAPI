//
//  NetworkManager.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/15/22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    private let coreDataManager = CoreDataManager.shared
    private var questions = [Question]()
    
    func fetchData(page: Int, completion: @escaping ([Question]?, Error?) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.stackexchange.com"
        components.path = "/2.3/questions"
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "sort", value: "month"),
            URLQueryItem(name: "site", value: "stackoverflow"),
            URLQueryItem(name: "key", value: "YOUR_KEY")
        ]
        guard let url = components.url else {return}
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else {return}
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }
            do {
                let questions = try JSONDecoder().decode(Questions.self, from: data)
                DispatchQueue.main.async {
                    self.coreDataManager.saveQuestions(questions: questions.items)
                }
                completion(questions.items, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}
