//
//  MovieService.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 11/01/23.
//

import Foundation
import UIKit


final class MovieService {
   private var service: ServideProvider
    
    init(service: ServideProvider = Service()) {
        self.service = service
    }
    
    func fetchResults(_ search: String, result: @escaping(Result<[SearchShowElement], ServiceError>) -> ()) {
        let parameters = ["q": search]
        service.makeRequest(endpoints: .search, parameters: parameters) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
    
    func fetchList(result: @escaping (Result<[Movie], ServiceError>) -> ()) {
        service.makeRequest(endpoints: .shows, parameters: nil) { response in
            DispatchQueue.main.async {
                result(response)
            }
        }
    }
}

