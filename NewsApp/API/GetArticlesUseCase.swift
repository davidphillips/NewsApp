//
//  GetArticlesUseCase.swift
//  NewsApp
//
//  Created by David Phillips on 1/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetArticlesUseCase {
    
    let url = "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full"
    
    func request(delegate: GetArticlesDelegate) {
        
        print("GetArticlesUseCase Request")
    
        AF.request(url, method: .get, parameters: nil)
            .responseJSON { response in
            
                switch response.result {
                case .success(let value as Any?):
                    let json = JSON(value!)
                    
                    let jsonArticles = json["assets"].arrayValue
                    
                    //print(jsonArticles.debugDescription)
                    
                    var articles: [NewsArticle] = []
                    
                    for element in jsonArticles {
                        if let article = NewsArticle(JSONString: element.rawString() ?? "") {
                            articles.append(article)
                        }
                    }
                    
                    delegate.getArticlesResults(success: true, articles: articles)
                    
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            
                    delegate.getArticlesResults(success: false, articles: [])
                }
        }
        
    }
}

protocol GetArticlesDelegate {
    func getArticlesResults(success: Bool, articles: [NewsArticle])
}
