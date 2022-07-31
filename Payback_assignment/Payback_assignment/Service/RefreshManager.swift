//
//  RefreshManager.swift
//  Payback_assignment
//
//  Created by Anzer Arkin on 31.07.22.
//

import Foundation

final class RefreshManager: NSObject {

    static let shared = RefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastRefresh"
    private let calender = Calendar.current

    /// Load data only after 24 hours
    func loadDataIfNeeded(completion: (Bool) -> Void) {

        if isRefreshRequired() {
            defaults.set(Date(), forKey: defaultsKey)
            completion(true)
        } else {
            completion(false)
        }
    }

    private func isRefreshRequired() -> Bool {

        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }

        if let diff = calender.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, diff > 24 {
            return true
        } else {
            return false
        }
    }
}
