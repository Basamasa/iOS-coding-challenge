//
//  Routes.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import Foundation

/// Api routes for Flickr photos search api method
struct Routes {
    static var api_key = "3b3606dd-1d09-4021-a013-a30e958ad930"
    static var baseURL = "https://firebasestorage.googleapis.com/v0/b/payback-test.appspot.com/o/feed.json?alt=media&token=" + api_key
    
    /**
     Return requested url base on serch text and page number
     
     - returns: Request configuration
     */
    static func searchRequest() -> Request? {
        let reqConfig = Request.init(requestMethod: .get, urlString: Routes.baseURL)
        return reqConfig
    }
    
}

enum Result <T> {
    case Success(T)
    case Failure(String)
    case Error(String)
}

enum RequestMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    
    var value: String {
        return self.rawValue
    }
}
