//
//  DateFormatter+LTV.swift
//  ltvios
//
//  Created by gabriel durican on 4/2/22.
//

import Foundation

extension DateFormatter {
    //DateFormatters are expensive (resources wise) to create so we make a static value that will be reused everywhere in the app
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
