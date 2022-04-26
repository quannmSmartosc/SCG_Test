//
//  HeadlineUseCase.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import RxSwift

protocol HeadlineUseCase {
    func getHeadlineArticles(page: Int) -> Single<NewsResponse>
    func searchArticles(query: String, page: Int) -> Single<NewsResponse>
}
