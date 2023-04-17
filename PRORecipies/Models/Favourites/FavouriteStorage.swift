//
//  FavouriteStorage.swift
//  PRORecipies
//
//  Created by Денис Жимоедов on 14.04.2023.
//

import Foundation

final class FavouritesIdsStorage {
    typealias ID = String
    private let storage: KeyValueStorage
    private let keyStorage = "favourites"

    init(storage: KeyValueStorage){
        self.storage = storage
    }

    func addToFavourite(_ foodId: ID) {
        storage.addArray(foodId, forKey: keyStorage)
    }

    func getFavouriteFoodsIds() -> Array<ID> {
        storage.value(forKey: keyStorage, default: [])
    }

    func deleteFavouriteFoodsIds(_ foodId: ID) {
        storage.deleteArray(foodId, forKey: keyStorage)
    }

    func isFavourite(_ foodId: ID) -> Bool {
        return storage.inArray(foodId, forKey: keyStorage)
    }
}

extension KeyValueStorage {
    fileprivate func addArray(_ value: String, forKey key: String) {
        var arr: Array<String> = self.value(forKey: key, default: [])
        arr.append(value)
        self.setValue(arr, forKey: key)
    }

    fileprivate func deleteArray(_ value: String, forKey key: String) {
        var arr: Array<String> = self.value(forKey: key, default: [])
        arr = arr.filter { $0 != value }
        self.setValue(arr, forKey: key)
    }

    fileprivate func inArray(_ value: String, forKey key: String) -> Bool {
        let arr: Array<String> = self.value(forKey: key, default: [])
        return arr.contains(value)
    }
}
