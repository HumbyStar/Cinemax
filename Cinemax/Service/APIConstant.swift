//
//  APIConstant.swift
//  Cinemax
//
//  Created by Humberto Rodrigues on 10/01/23.
//


enum APIConstant {
    static var baseURL = "https://api.tvmaze.com/"
    
    enum endpoints {
        case shows
        case episodes(Int)
        case search
    
    
    var path: String{
        switch self{
        case .search:
            return "search/shows"
        case .shows:
            return "shows"
        case .episodes(let ID):
            return "shows/\(ID)/episodes"
        }
    }
    
    
    var urlString: String {
        return APIConstant.baseURL + path
    }
    }
}



