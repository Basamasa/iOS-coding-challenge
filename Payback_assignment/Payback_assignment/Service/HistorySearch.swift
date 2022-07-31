//
//  HistorySearch.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import Foundation

/// Search history database
final class HistorySearch {
    static let historySearchesId = "history-searches"

    static var historySearches: [String] {
        get {
            let defaults = UserDefaults.standard
            return defaults.stringArray(forKey: historySearchesId) ?? [String]()
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: historySearchesId)
        }
    }
    
    /**
     Insert history searched text into user database
     
     - Parameters:
       - text: History search text
     */
    static func insertHistory(text: String) {
        var historySearches = historySearches
        if historySearches.count > 4 {
            historySearches.removeLast()
        }
        historySearches.insert(text, at: 0)
        HistorySearch.historySearches = historySearches
    }
}
