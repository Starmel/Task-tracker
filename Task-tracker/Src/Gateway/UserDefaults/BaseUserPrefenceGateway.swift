//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


class BaseUserDefaultsGateway {

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    var defaults: UserDefaults


    init(_ preference: UserDefaults) {
        self.defaults = preference
    }

    func read<T: Codable>(_ key: String) -> T? {
        let data = defaults.value(forKey: key) as? Data
        guard data != nil else {
            return nil
        }
        return try? decoder.decode(T.self, from: data!)
    }

    func save<T: Codable>(_ key: String, _ value: T?) {
        print("UserSettings: save '\(key)' = '\(value ?? ("!nil!" as Any))'")
        if value == nil {
            defaults.set(nil, forKey: key)
            return
        }
        let data = try! encoder.encode(value)
        defaults.set(data, forKey: key)
    }
}
