//
//  RxStore.swift
//  Whatever
//
//  Created by Retno Widyanti on 15/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class RxStore: NSObject {
    public static let standard = RxStore()
    
    // MARK: UserDefaults
    // Checks whether UserDefaults contains a given key.
    public func containsValue(forKey key: String) -> Single<Bool> {
        return Single.create { single in
            single(.success(UserDefaults.standard.object(forKey: key) != nil))
            return Disposables.create()
        }
    }
    
    // Removes the values saved in User Defaults given corresponding keys.
    public func remove(forKeys keys: [String]) -> Completable {
        return Completable.create {completable in
            for key in keys {
                UserDefaults.standard.removeObject(forKey: key)
            }
            completable(.completed)
            return Disposables.create()
        }
    }
    
    // Sets the value given a key in User Defaults.
    public func set<T:Codable>(value: T, forKey key: String) -> Completable {
        return Completable.create {completable in
            UserDefaults.standard.set(value, forKey: key)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    // Retrieves a value given a key in User Defaults.
    public func get<T>(forKey key: String) -> Single<T> {
        return Single.create { single in
            guard let retrievedValue = UserDefaults.standard.object(
                forKey: key) as? T else {
                single(.error(ApplicationError.generic))
                return Disposables.create()
            }
            single(.success(retrievedValue))
            return Disposables.create()
        }
    }
    
    // Replaces the value in UserDefaults for the given key and returns previously saved value if one exists, otherwise falls back to a default value.
    public func replace<T>(
        value: T,
        forKey key: String,
        defaultValue: T? = nil) -> Single<T?> {
        return Single.create { single in
            let oldValue = UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
            UserDefaults.standard.set(value, forKey: key)
            single(.success(oldValue))
            return Disposables.create()
        }
    }
    
    // MARK: Keychain
    
    // Updates existing value (if exists), or saves new value to Keychain.
    public func setSecureValue(
        value: String,
        forKey key: String) -> Completable {
        return Completable.create {completable in
            do {
                // Create a new keychain item with the key.
                let secureItem = KeychainSecureItem(key: key)
                
                // Save the password for the new item.
                try secureItem.saveSecureValue(value)
                completable(.completed)
                return Disposables.create()
                
            } catch {
                completable(.error(error))
                return Disposables.create()
            }
        }
    }
    
    // Retrieves value (if exists) from Keychain for given key.
    public func getSecureValue(forKey key: String) -> Single<String> {
        return Single.create { single in
            do {
                let secureItem = KeychainSecureItem(key: key)
                let keychainItem = try secureItem.readSecureValue()
                single(.success(keychainItem))
            } catch {
                single(.error(SecureItemError.itemNotFound))
            }
            return Disposables.create()
        }
    }
    
    // Clear all saved keychain items.
    private func clearKeychainItems() throws {
        do {
            let keychainItems = try KeychainSecureItem.secureItems(
                forService: KeychainConfiguration.serviceName)
            for item in keychainItems {
                try item.deleteItem()
            }
        } catch  {
            throw SecureItemError.cannotClearSecureValues
        }
    }
    
    // MARK: Shared
    // Clears all user defaults and Keychain items.
    public func clear() -> Completable {
        return Completable.create {completable in
            
            guard let domain = Bundle.main.bundleIdentifier else {
                return Disposables.create()
            }
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            do {
                try self.clearKeychainItems()
                completable(.completed)
                return Disposables.create()
            } catch {
                completable(.error(error))
                return Disposables.create()
            }
        }
    }
}

enum SecureItemError: Error {
    case itemNotFound               // Item not found in UserDefaults.
    case cannotClearSecureValues    // Encountered issue clearing Keychain.
}

