//
//  DateUtils.swift
//  NewsApp
//
//  Created by David Phillips on 6/12/19.
//  Copyright © 2019 David Phillips. All rights reserved.
//

import Foundation

class DateUtils {
    
    // Convert a 13 digit timeStamp into a date string to be presented to a user
    static func convertTimeStampIntToDateString(_ timeStamp: Int) -> String {
        let timeInterval = Double(timeStamp / 1000) //Divide by 1000 to convert into seconds
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm - dd MMM"
        
        return dateFormatter.string(from: date)
    }

}
