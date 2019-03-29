//
//  Extensions.swift
//  Upcoming Movies
//
//  Created by Pedro Bandeira on 2/2/19.
//

import UIKit

extension String {
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}

extension UILabel {
    func adjustFontWidth() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.2
    }
}
