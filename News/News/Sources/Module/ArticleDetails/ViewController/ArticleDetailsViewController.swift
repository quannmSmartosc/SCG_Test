//
//  ArticleDetailsViewController.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class ArticleDetailsViewController: BaseViewController<ArticleDetailsViewModel> {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private var article: Article? {
        didSet {
            renderArticle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Details"
        viewModel?.getArticle()
    }
    
    override func bind() {
        let input = ArticleDetailsViewModel.Input()
        let output = viewModel?.transform(input: input)
        
        output?.article
            .drive(onNext: { [weak self] data in
                self?.article = data
            }).disposed(by: disposeBag)
    }
    
    private func renderArticle() {
        guard let article = article else { return }
        articleImageView.displayImageString(article.urlToImage)
        setContentLabel(titleLabel, contentText: article.title)
        setContentLabel(authorLabel, contentText: article.author)
        setContentLabel(contentLabel, contentText: article.content)
        setContentLabel(sourceLabel, contentText: article.source?.name, startFrom: true)
        setContentLabel(dateLabel, contentText: article.publishedAt, startFrom: true)
    }
    
    private func setContentLabel(_ label: UILabel, contentText: String?, startFrom: Bool = false) {
        if let contentText = contentText {
            label.text = startFrom ? "From \(contentText)" : contentText
            label.isHidden = false
        } else {
            label.isHidden = true
        }
    }
    
}
