//
//  HomeArticleListCell.swift
//  News
//
//  Created by Baboon on 21/04/2022.
//

import UIKit

class HomeArticleListCell: BaseTableViewCell<HomeArticleCellViewModel> {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!

    override func setupCell() {
        viewModel.dataDisplay.subscribe(onNext: { [weak self] article in
            guard let data = article else { return }
            self?.titleLabel.text = data.title ?? ""
            self?.contentLabel.text = data.content ?? ""
            self?.authorLabel.text = data.author ?? ""
            self?.sourceLabel.text = data.source?.name ?? ""
            self?.articleImageView.displayImageString(article?.urlToImage)
            if let publishedDate = data.publishedAt {
                self?.dateLabel.text = publishedDate.formattedDateDisplay
            }
        }).disposed(by: disposeBag)
    }
    
}
