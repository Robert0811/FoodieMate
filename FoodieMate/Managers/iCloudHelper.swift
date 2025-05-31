//
//  iCloudHelper.swift
//  FoodieMate
//
//  Created by Robert Trifan on 29.05.2025.
//

import Foundation

struct iCloudHelper {
    static func save(key: String, value: Any) {
        let store = NSUbiquitousKeyValueStore.default
        store.set(value, forKey: key)
        store.synchronize()
    }

    static func load(key: String) -> Any? {
        let store = NSUbiquitousKeyValueStore.default
        return store.object(forKey: key)
    }
}
