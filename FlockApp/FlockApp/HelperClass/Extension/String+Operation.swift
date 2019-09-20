//
//  String+Operation.swift
//
//  Created by Ravi vora on 17/09/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

extension String {
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    var isBlank:Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString.isEmpty
    }
    
    func removewhitespace() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
    
    static var quotes: (String, String) {
        guard
            let bQuote = Locale.current.quotationBeginDelimiter,
            let eQuote = Locale.current.quotationEndDelimiter
            else { return ("\"", "\"") }
        
        return (bQuote, eQuote)
    }
    
    var quoted: String {
        let (bQuote, eQuote) = String.quotes
        return bQuote + self + eQuote
    }
    
    /// Check if string is valid email format.
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
