//
//  HomeViewModel.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

import XCoordinator

final class HomeViewModel: BaseViewModel {
    @Injected var usecase: HeadlineUseCase
    
    private var totals: Int = 0
    private var articles: [Article] = []
    private var query: String = ""
    private var page: Int = 1
    
    private var loading: Bool = false {
        didSet {
            if page == 1 {
                isShowLoading.onNext(loading)
            }
        }
    }
    
    var articlesData: BehaviorSubject<[Article]> = BehaviorSubject(value: [])
    private var errorData: BehaviorSubject<Error?> = BehaviorSubject(value: nil)
    private var isShowLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    struct Input {
        let searchTrigger: Driver<String?>
    }
    
    struct Output {
        let error: Driver<Error?>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        input.searchTrigger
            .drive(queryBinding).disposed(by: disposeBag)
        return Output(error: errorData.asDriver(onErrorJustReturn: nil),
                      isLoading: isShowLoading.asDriver(onErrorJustReturn: false))
    }
    
    private var queryBinding: Binder<String?> {
        return Binder(self, binding: { (vc, keyword) in
            self.query = keyword ?? ""
            guard let keyword = keyword else {
                self.page = 1
                self.getHeadline()
                return
            }
            if keyword.count > 2 {
                self.page = 1
                self.searchArticles()
            }
        })
    }
    
    func shouldPaging(_ currentIndex: IndexPath) {
        if currentIndex.row == articles.count - 3 {
            paging()
        }
    }
    
    func viewArticleAt(_ index: IndexPath) {
        router.trigger(.details(articles[index.row]))
    }
}

extension HomeViewModel {
    private func searchArticles() {
        loading = true
        usecase.searchArticles(query: query, page: page)
            .subscribe(onSuccess: handleResponse(_:), onError: handleError(_:))
            .disposed(by: disposeBag)
    }
    
    func getHeadline() {
        
        loading = true
        usecase.getHeadlineArticles(page: page)
            .subscribe(onSuccess: handleResponse(_:), onError: handleError(_:))
            .disposed(by: disposeBag)
    }
    
    private func paging() {
        if totals <= articles.count {
            return
        }
        if !loading {
            page += 1
            if query.isEmpty {
                getHeadline()
            } else {
                searchArticles()
            }
        }
        
    }
    
    private func handleError(_ error: Error) {
        loading = false
        errorData.onNext(error)
    }
    
    private func handleResponse(_ response: NewsResponse) {
        loading = false
        totals = response.totalResults ?? 0
        if page == 1 {
            articles.removeAll()
        }
        articles.append(contentsOf: response.articles ?? [])
        articlesData.onNext(articles)
    }
}
