//
//  Utils.swift
//  PlaystationPedia
//
//  Created by rzamau on 09/10/22.
//

import Foundation

extension String {
    func formatDate() -> Date {
    let dateString = self
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: dateString)!
    }
}

extension Double {
    func ridZero() -> String {
        let value = String(format: "%g", self)
        return value
    }
}

extension String {
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
}
