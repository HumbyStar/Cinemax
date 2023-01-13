//
//  Service.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 10/01/23.
//

import Foundation

enum ServiceError: Error {
    case badRequest
    case statusCode(Int)
    case parseError
}

protocol ServideProvider {
    func makeRequest<T:Codable>(endpoints: APIConstant.endpoints, parameters: [String: String?]? ,result: @escaping (Result<T,ServiceError>) -> ())
}


class Service: ServideProvider {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type":"application/json","Accept":"application/json"]
        config.httpMaximumConnectionsPerHost = 5
        config.timeoutIntervalForRequest = 30.0
        config.allowsCellularAccess = false
        return URLSession(configuration: config)
    }()
    
    func makeRequest<T>(endpoints: APIConstant.endpoints, parameters: [String : String?]?, result: @escaping (Result<T, ServiceError>) -> ()) where T : Decodable, T : Encodable {
        guard var components = URLComponents(string: endpoints.urlString) else {
            result(.failure(ServiceError.parseError))
            return
        }
        components.queryItems = parameters?.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = components.url else {return}
        print(url)
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse, let data = data else {
                result(.failure(ServiceError.badRequest))
                return
            }
            do {
                guard response.statusCode == 200 else {
                    result(.failure(ServiceError.statusCode(response.statusCode)))
                    return
                }
                let codable = try JSONDecoder().decode(T.self, from: data)
                result(.success(codable))
                
            } catch {
                print (error)
                result(.failure(ServiceError.parseError))
            }
        
           
        }
        dataTask.resume()
    }
}


