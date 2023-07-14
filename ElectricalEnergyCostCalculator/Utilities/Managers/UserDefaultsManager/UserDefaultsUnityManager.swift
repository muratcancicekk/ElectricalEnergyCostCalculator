//
//  UserDefaultsUnityManager.swift
//  ElectricalEnergyCostCalculator
//
//  Created by Murat Çiçek on 6.07.2023.
//

import Foundation

struct UserDefaultsUnityManager<T> {
    private let userDefaults = UserDefaults.standard
    private let key: String
    
    init(key: UserDefaultsKeys) {
        self.key = key.rawValue
    }
    
    func save(data: T?) {
        userDefaults.set(data, forKey: key)
    }
    
    func read() -> T? {
        return userDefaults.value(forKey: key) as? T
    }

    func delete() {
        userDefaults.removeObject(forKey: key)
    }

    func setModel(_ object: T) throws where T: Encodable {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            throw ObjectSavableError.unableToEncode
        }
    }

    func getModel() throws -> T where T: Decodable {
        guard let data = userDefaults.data(forKey: key) else { throw ObjectSavableError.noValue }
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            throw ObjectSavableError.unableToDecode
        }
    }
}
