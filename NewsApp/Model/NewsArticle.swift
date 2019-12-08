//
//  NewsArticle.swift
//  NewsApp
//
//  Created by David Phillips on 1/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//
// The News Articles containg the article's basic details and url to the source of the article.
//

import Foundation
import UIKit
import ObjectMapper

class NewsArticle: Mappable {
    
    var url: String?
    var headline: String?
    var abstract: String?
    var byLine: String?
    var timeStamp: Int?
    var relatedImages: [NewsArticleImage] = []
    var thumbnail: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url       <- map["url"]
        headline  <- map["headline"]
        abstract  <- map["theAbstract"]
        byLine    <- map["byLine"]
        timeStamp <- map["timeStamp"]
        relatedImages <- map["relatedImages"]
        
        self.setThumbnail()
    }
    
    //Set the thumbnail to be the smallest image from the relatedImages array
    func setThumbnail() {
        if relatedImages.count > 0 {
            if let url = getSmallestImageUrl(images: relatedImages) {
                thumbnail = url
            }
        }
    }
    
    private func getSmallestImageUrl(images: [NewsArticleImage]) -> String? {
        let image = images.min(by: { $0.size! < $1.size! })
        return image?.url
    }
    
    
}
