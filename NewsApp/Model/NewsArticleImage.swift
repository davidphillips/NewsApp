//
//  NewsArticleImage.swift
//  NewsApp
//
//  Created by David Phillips on 1/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//
// The News Articles associated images. A News Article can have multiple images.
//

import Foundation
import ObjectMapper

class NewsArticleImage: NSObject, Mappable {
    
    var url: String?
    var width: Int?
    var height: Int?
    var size: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url     <- map["url"]
        width   <- map["width"]
        height  <- map["height"]
        
        if width != nil && height != nil {
            size = width! * height!
        }

    }
}
