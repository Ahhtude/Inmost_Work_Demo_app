//
//  NetworkService.swift
//  Inmost_Work_Demo_app
//
//  Created by Sergey berdnik on 24.06.2020.
//  Copyright © 2020 Sergey berdnik. All rights reserved.
//

import Foundation
import Alamofire

 fileprivate struct Constants {
    static let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c="
    static let filtersURL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"

}

protocol CoctailsListDataManagerProtocol {
    func getCoctails(filter: String, resultHandler: @escaping ([DrinkFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ())
    func getFilters(resultHandler: @escaping ([Filters]) -> (), errorHandler: @escaping (NetworkError?) -> ())
}

enum NetworkError: Error {
    case server(Int, String, URL?)
}

struct HttpStatusCode {
    static let successful           = 200
}

class Page<Model: Decodable>: Decodable {
    typealias ItemType = Model
    private(set) var items: [Model]
    
    private enum CodingKeys: String, CodingKey {
        case items = "drinks"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            items = try values.decode([Model].self, forKey: .items)
        } catch let error {
            print(error)
            items = []
        }
    }
}


class CoctailsListDataManager: NSObject, CoctailsListDataManagerProtocol {
    func getCoctails(filter: String, resultHandler: @escaping ([DrinkFeed]) -> (), errorHandler: @escaping (NetworkError?) -> ()) {
        let path = (Constants.baseURL + filter).replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: path) else { return }
        
        Alamofire.request(url).responseJSON { response in
            var responseData: Page<DrinkFeed>?
            var error: NetworkError?
            
            if response.response?.statusCode == HttpStatusCode.successful, let data = response.data {
                
                let decoder = JSONDecoder()
                do {
                    responseData =  try decoder.decode(Page<DrinkFeed>.self, from: data)
                } catch _ {
                    error = NetworkError.server(response.response?.statusCode ?? 0, "Can not decodable response", response.request?.url)
                }
            }
            
            if responseData != nil {
                resultHandler(responseData?.items ?? [])
            } else {
                errorHandler(error)
            }
        }
    }
    
    func getFilters(resultHandler: @escaping ([Filters]) -> (), errorHandler: @escaping (NetworkError?) -> ()) {
        let path = Constants.filtersURL.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: path) else { return }
        Alamofire.request(url).responseJSON { response in
            var responseData: Page<Filters>?
            var error: NetworkError?
            if response.response?.statusCode == HttpStatusCode.successful, let data = response.data {
                let decoder = JSONDecoder()
                do {
                    responseData =  try decoder.decode(Page<Filters>.self, from: data)
                } catch _ {
                    error = NetworkError.server(response.response?.statusCode ?? 0, "Can not decodable response", response.request?.url)
                }
            }
            if responseData != nil {
                resultHandler(responseData?.items ?? [])
            } else {
                errorHandler(error)
            }
        }
    }
}
