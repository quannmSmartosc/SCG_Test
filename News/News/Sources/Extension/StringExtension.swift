//
//  StringExtension.swift
//  News
//
//  Created by Baboon on 22/04/2022.
//

import Foundation

extension String {
    
    var formattedDateDisplay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "MMM d, h:mm a"
            return formatter.string(from: date)
        }
        return ""
    }
}



