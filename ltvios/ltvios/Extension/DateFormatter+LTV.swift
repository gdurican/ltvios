//
//  DateFormatter+LTV.swift
//  ltvios
//
//  Created by gabriel durican on 4/2/22.
//

import Foundation

extension DateFormatter {
    static let ltvFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        
        return formatter
    }()
    
    static let dayMonthYearFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        
        return formatter
    }()
}
