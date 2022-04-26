//
//  Configs.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation

class ConfigsManager {
    
    @Injected var config: ApiConfiguration
    static let shared = ConfigsManager()
}

class DevApi: ApiConfiguration {
    var baseURL = "https://newsapi.org/v2"
    var apiKey = "f570362e84b74afaaab6222b5a585466"
}

class ProdApi: ApiConfiguration {
    var baseURL = "https://newsapi.org/v2"
    var apiKey = "f570362e84b74afaaab6222b5a585466"
}

protocol ApiConfiguration {
    var baseURL: String { get }
    var apiKey: String { get }
}
