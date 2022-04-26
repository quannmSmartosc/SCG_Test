//
//  HeadlineTargetType.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import Moya

// MARK: - Provider support

let pageSize = 12
let defaultCountry = "us"

public enum Headline {
    case list(page: Int)
    case search(query: String, page: Int)
}

extension Headline: TargetType {
    
    public var sampleData: Data {
        return "{\"id\": 100}".data(using: String.Encoding.utf8)!
    }
    
    public var baseURL: URL {
        return URL(string: ConfigsManager.shared.config.baseURL)!
    }
    
    public var path: String {
        return "/everything"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task{
        switch self {
        case .list(let page):
            let parameters: [String : Any] = ["apiKey": ConfigsManager.shared.config.apiKey,
                                              "pageSize": pageSize,
                                              "page": page, "sources":
                                                "abc-news"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .search(let query, let page):
            let parameters: [String : Any] = ["apiKey": ConfigsManager.shared.config.apiKey,
                                              "pageSize": pageSize,
                                              "page": page,
                                              "q": query,
                                              "sources": "abc-news"]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var validationType: ValidationType {
        return .none
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
