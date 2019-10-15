//
//  NetworkConfiguration.swift
//  Movie
//
//  Created by saw pyaehtun on 27/09/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation

enum MovieResponseKey{
    
    case results
    case genres
    
    func keyString() -> String {
        switch self {
        case .results:
            return "results"
        case .genres:
            return "genres"
        }
    }
}

enum MovieAPI {
    case genre
    case posters
    
    func urlStringWithPageID() -> String {
        return NetworkConfiguration.urlStringWithPageID(apiString: apiString())
    }
    
    func urlString() -> String {
        return NetworkConfiguration.urlString(apiString: apiString())
    }
    
    func apiString() -> String {
        switch self {
        case .genre:
            return "/genre/movie/list"
        case .posters:
            return ""
        }
    }
    
    //MARK:- ACCOUNT
    enum account {
        case account
        case getMovieWatchList
        case addToWatchList
        case getRatedMovies
        
        func urlStringWithPageID() -> String {
            return NetworkConfiguration.urlStringWithPageID(apiString: "/account" + apiString())
        }
        
        func urlString() -> String {
            return NetworkConfiguration.urlString(apiString: "/account" + apiString())
        }
        
        func urlStringWithSessionID() -> String {
            return NetworkConfiguration.urlStringWithSessionID(apiString : "/account" + apiString())
        }
        
        func urlStringWithSessionIDAndPageID() -> String {
            return NetworkConfiguration.urlStringWithSessionIDAndPageID(apiString : "/account" + apiString())
        }
        
        func apiString() -> String {
            switch self {
            case .account :
                return ""
            case .getMovieWatchList :
                return "/%@/watchlist/movies" //account_id
            case .addToWatchList :
                return "/%@/watchlist" //account_id
            case .getRatedMovies :
                return "/%@/rated/movies" // account_id
            }
        }
    }
    
    //MARK:- SEARCH
    enum search {
        case movie
        
        func urlStringWithPageID() -> String {
            return NetworkConfiguration.urlStringWithPageID(apiString: "/search" + apiString())
        }
        
        func urlString() -> String {
            return NetworkConfiguration.urlString(apiString: "/search" + apiString())
        }
        
        func apiString() -> String {
            switch self {
            case .movie:
                return "/movie"
            }
        }
    }
    
    //MARK:- MOVIE
    enum movie {
        case nowPlaying
        case popular
        case topRated
        case upComing
        case similar
        case detail
        case video
        case rating
        
        func urlStringWithPageID() -> String {
            return NetworkConfiguration.urlStringWithPageID(apiString: "/movie" + apiString())
        }
        
        func urlString() -> String {
            return NetworkConfiguration.urlString(apiString: "/movie" + apiString())
        }
        
        func urlStringWithSessionID() -> String {
            return NetworkConfiguration.urlStringWithSessionID(apiString : "/movie" + apiString())
        }
        
        func urlStringWithSessionIDAndPageID() -> String {
            return NetworkConfiguration.urlStringWithSessionIDAndPageID(apiString : "/movie" + apiString())
        }
        
        func apiString() -> String {
            switch self {
            case .topRated :
                return "/top_rated"
            case .nowPlaying :
                return "/now_playing"
            case .popular :
                return "/popular"
            case .upComing :
                return "/upcoming"
            case .similar :
                return "/%@/similar"
            case .detail :
                return "/%@"
            case .video :
                return "/%@/videos"
            case .rating :
                return "/%@/rating" // movie id
            }
        }
    }
    
    //MARK:- AUTHENTIICATION
    enum authentication {
        case requestToken
        case tokenValidateWithLogin
        
        func urlStringWithPageID() -> String {
            return NetworkConfiguration.urlStringWithPageID(apiString: "/authentication" + apiString())
        }
        
        func urlString() -> String {
            return NetworkConfiguration.urlString(apiString: "/authentication" + apiString())
        }
        
        func apiString() -> String {
            switch self {
            case .requestToken:
                return "/token/new"
            case .tokenValidateWithLogin:
                return "/token/validate_with_login"
            }
        }
    }
}

//MARK:- NETWORK CONFIGURATION
struct NetworkConfiguration {
    
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let BASE_IMG_URL = "https://image.tmdb.org/t/p/w500"
    static let KEY = "?api_key=3ea4500e51ab3b0358547f472e44d5fc"
    static let SESSION_ID = "1c9cf3211a9cd464048cf6a9a001bd6166f98ded"
    
    static func urlStringWithPageID(apiString : String) -> String {
        return "\(BASE_URL)\(apiString)\(KEY)&page="
    }
    
    static func urlString(apiString : String) -> String {
        return "\(BASE_URL)\(apiString)\(KEY)"
    }
    
    static func urlStringWithSessionID(apiString : String) -> String {
        return "\(BASE_URL)\(apiString)\(KEY)&session_id=\(SESSION_ID)"
    }
    
    static func urlStringWithSessionIDAndPageID(apiString : String) -> String {
        return "\(BASE_URL)\(apiString)\(KEY)&session_id=\(SESSION_ID)&page="
    }
}
