//
//  KeyValueStorage.swift
//  PRORecipies
//
//  Created by Денис Жимоедов on 13.04.2023.
//

import Foundation

protocol KeyValueStorage {
    func value<T: Codable>(forKey key: String, `default`: T) -> T
    func setValue<T: Codable>(_ value: T?, forKey key: String)
}

final class PersistentStorage: KeyValueStorage {
    private let userDefaults: UserDefaults

    init(
        userDefaults: UserDefaults
    ) {
        self.userDefaults = userDefaults
    }

    func value<T: Codable>(forKey key: String, `default`: T) -> T {
        userDefaults.object(forKey: key) as? T ?? `default`
    }

    func setValue<T: Codable>(_ value: T?, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
}
