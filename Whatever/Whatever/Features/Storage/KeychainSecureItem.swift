//
//  KeychainSecureItem.swift
//  Whatever
//
//  Created by Retno Widyanti on 15/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import Foundation

struct KeychainSecureItem {
    // MARK: Types
    enum KeychainError: Error {
        case noSecureData           // Value does not exist in Keychain
        case unexpectedSecureData   // Value of an unexpected type is returned
        case unexpectedItemData     // Item cannot be cast to Dictionary
        case unhandledError(status: OSStatus)
    }
    
    // MARK: Properties
    let service: String
    private(set) var key: String
    let accessGroup: String?
    
    // MARK: Intialization
    init(service: String, key: String, accessGroup: String? = nil) {
        self.service = service
        self.key = key
        self.accessGroup = accessGroup
    }
    
    init(key: String) {
        self.service = KeychainConfiguration.serviceName
        self.key = key
        self.accessGroup = KeychainConfiguration.accessGroup
    }
    
    // MARK: Keychain access
    // Retrieves secure value from Keychain.
    func readSecureValue() throws -> String  {
        
        // Build a query to find item matching service, key and access group.
        var query = KeychainSecureItem.keychainQuery(withService: service, key: key, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noSecureData }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Parse the secure string from the query result.
        guard let existingItem = queryResult as? [String : AnyObject],
            let secureData = existingItem[kSecValueData as String] as? Data,
            let secureValue = String(data: secureData, encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedSecureData
        }
        
        return secureValue
    }
    
    // Updates existing item in Keychain.
    func saveSecureValue(_ secureValue: String) throws {
        // Encode the value into an Data object.
        let encodedValue = secureValue.data(using: String.Encoding.utf8)!
        
        do {
            // Check for an existing item in the keychain.
            try _ = readSecureValue()
            
            // Update the existing item with the new value.
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedValue as AnyObject?
            
            let query = KeychainSecureItem.keychainQuery(withService: service, key: key, accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
            
        catch KeychainError.noSecureData {
            /*
             No value was found in the keychain. Create a dictionary to save
             as a new keychain item.
             */
            var newItem = KeychainSecureItem.keychainQuery(withService: service, key: key, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedValue as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }
    
    // Renames existing key in Keychain.
    mutating func renameAccount(_ newKey: String) throws {
        // Try to update an existing item with the new key.
        var attributesToUpdate = [String : AnyObject]()
        attributesToUpdate[kSecAttrAccount as String] = newKey as AnyObject?
        
        let query = KeychainSecureItem.keychainQuery(withService: service, key: self.key, accessGroup: accessGroup)
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
        
        self.key = newKey
    }
    
    // Deletes item from Keychain.
    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeychainSecureItem.keychainQuery(withService: service, key: key, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
    
    
    // Retrieves all items stored in Keychain for a given service and access group.
    static func secureItems(
        forService service: String,
        accessGroup: String? = nil) throws -> [KeychainSecureItem] {
        // Build a query for all items that match the service and access group.
        var query = KeychainSecureItem.keychainQuery(withService: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanFalse
        
        // Fetch matching items from the keychain.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return [] }
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String : AnyObject]] else { throw KeychainError.unexpectedItemData }
        
        // Create a `KeychainSecureItem` for each dictionary in the query result.
        var secureItems = [KeychainSecureItem]()
        for result in resultData {
            guard let key  = result[kSecAttrAccount as String] as? String else { throw KeychainError.unexpectedItemData }
            
            let secureItem = KeychainSecureItem(service: service, key: key, accessGroup: accessGroup)
            secureItems.append(secureItem)
        }
        
        return secureItems
    }
    
    // MARK: Convenience
    // Constructs Leychain query.
    private static func keychainQuery(withService service: String, key: String? = nil, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        
        if let key = key {
            query[kSecAttrAccount as String] = key as AnyObject?
        }
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
