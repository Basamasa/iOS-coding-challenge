//
//  APIHelper.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 26.07.22.
//

import Foundation

import UIKit

/// Api helper that request and parser json results
final class PayBackAPI {
    /**
     API get request from PayBack api.
     
     - Parameters:
        - searchText: Search term
        - pageNo: Page number
        - completion: Handler to retrieve result
     */
    func requestFeed() async -> Result<TileList?> {
        
        guard let request1 = Routes.searchRequest() else {
            return .Error("")
        }
        
        let result = await RequestManager.shared.request(request1)
        switch result {
        case .Success(let responseData):
            if let model = self.parser(responseData) {
                return .Success(model)
            } else {
                return .Failure(RequestManager.errorMessage)
            }
        case .Failure(let message):
            return .Failure(message)
        case .Error(let error):
            return .Failure(error)
        }
    }
    
    /**
     Parser(Decoder) for json data
     
     - Parameters:
        - data: Response data from api
     - Returns: FlickrAPIResults instance
     */
    func parser(_ data: Data) -> TileList? {
        do {

            let responseModel = try JSONDecoder().decode(TileList.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }

extension Data
{
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}
