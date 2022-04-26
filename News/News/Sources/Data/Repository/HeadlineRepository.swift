//
//  HeadlineRepository.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation
import Moya
 
final class HeadlineRepository: HeadlineUseCase {
    
    func getHeadlineArticles(page: Int) -> Single<NewsResponse> {
        return HeadlineApi.shared.request(target: .list(page: page))
    }
    
    func searchArticles(query: String, page: Int) -> Single<NewsResponse> {
        return HeadlineApi.shared.request(target: .search(query: query, page: page))
    }
}
