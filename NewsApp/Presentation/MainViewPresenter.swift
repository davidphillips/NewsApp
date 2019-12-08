//
//  MainViewPresenter.swift
//  NewsApp
//
//  Created by David Phillips on 5/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import Foundation

class MainViewPresenter: NSObject, GetArticlesDelegate {
    
    internal var mView: MainView?

    let getArticlesUseCase = GetArticlesUseCase()

    func attachView<T>(view: T) where T : MainView {
        mView = view
    }
    
    func getArticles() {
        getArticlesUseCase.request(delegate: self)
    }
    
    func getArticlesResults(success: Bool, articles: [NewsArticle]) {
        mView?.returnedArticles(sortArticleByTimeStamp(articles))
    }
    
    private func sortArticleByTimeStamp(_ articles: [NewsArticle]) -> [NewsArticle] {
        return articles.sorted(by: { $0.timeStamp! > $1.timeStamp! })
    }

}


