//
//  FavouriteStorage.swift
//  PRORecipies
//
//  Created by Денис Жимоедов on 14.04.2023.
//

import Foundation

final class FavouritesIdsStorage {
    private let storage: KeyValueStorage
    private let keyStorage = "favourites"

    init(storage: KeyValueStorage){
        self.storage = storage
    }

    func addFavouriteFoodId(_ favouriteFoodId: String) {
        storage.addArray(favouriteFoodId, forKey: keyStorage)
    }

    func getFavouriteFoodsIds() -> Array<String> {
        storage.value(forKey: keyStorage, default: [])
    }
    func deleteFavouriteFoodsIds(_ favouriteFoodId: String) {
        storage.deleteArray(favouriteFoodId, forKey: keyStorage)
    }
    func isFavourite(_ favouriteFoodId: String) -> Bool {
        return storage.inArray(favouriteFoodId, forKey: keyStorage)
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
