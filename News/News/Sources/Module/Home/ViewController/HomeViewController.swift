//
//  HomeViewController.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import SwifterSwift

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel?.getHeadline()
    }
    
    override func bind() {
        
        guard let viewModel = self.viewModel else { return }
        
        let input = HomeViewModel.Input(searchTrigger: searchBar.rx.text.throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance).asDriver(onErrorJustReturn: nil))
        let output = viewModel.transform(input: input)
        
        output.error.drive(errorBinding).disposed(by: disposeBag)
        
        output.isLoading.drive(onNext: { loading in
            if loading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
        
        viewModel.articlesData
            .bind(to: tableView.rx.items(cellIdentifier: "HomeArticleListCell", cellType: HomeArticleListCell.self)) { index, item, cell in
                cell.viewModel = HomeArticleCellViewModel(with: item)
                cell.setupCell()
            }.disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
            .subscribe(onNext: { [weak self] cell in
                guard let self = self else { return }
                self.viewModel?.shouldPaging(cell.indexPath)
            })
            .disposed(by: viewModel.disposeBag)
        
        tableView.rx.itemSelected
            .debounce(.milliseconds(0), scheduler: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel?.viewArticleAt(indexPath)
            }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        tableView.register(nibWithCellClass: HomeArticleListCell.self)
        title = "News"
        navigationController?.isNavigationBarHidden = false
    }
    
    private var errorBinding: Binder<Error?> {
        return Binder(self, binding: { [weak self] (vc, error) in
            guard let error = error else { return }
            self?.displayError(error)
        })
    }
    
}

