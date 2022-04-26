//
//  ArticleDetailsViewModel.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import RxSwift
import RxCocoa
import XCoordinator

final class ArticleDetailsViewModel: BaseViewModel {
    private var articleData: BehaviorSubject<Article?> = BehaviorSubject(value: nil)
    private var article: Article?
    
    required init(with router: WeakRouter<AppRoute>) {
        super.init(with: router)
    }
    
    init(with router: WeakRouter<AppRoute>, articleData: Article) {
        super.init(with: router)
        article = articleData
    }
    
    struct Input {
    }
    
    struct Output {
        let article: Driver<Article?>
    }
    
    func transform(input: Input) -> Output {
        return Output(article: articleData.asDriver(onErrorJustReturn: nil))
    }
    
    func getArticle() {
        articleData.onNext(article)
    }
}
