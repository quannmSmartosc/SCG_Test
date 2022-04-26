//
//  HomeCellViewModel.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import RxSwift
import RxCocoa

class HomeArticleCellViewModel: BaseCellViewModel<Article> {
    var dataDisplay: BehaviorSubject<Article?> = BehaviorSubject(value: nil)
    
    override func setupViewModel() {
        dataDisplay.onNext(data)
    }
}

