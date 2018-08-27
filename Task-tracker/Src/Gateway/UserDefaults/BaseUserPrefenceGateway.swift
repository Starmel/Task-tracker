//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


class BaseUserDefaultsGateway {

    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    var defaults: UserDefaults


    init(_ preference: UserDefaults) {
        self.defaults = preference
    }

    func read<T: Codable>(_ key: UserDefaultKey) throws -> T? {
        let data = defaults.value(forKey: key.rawValue) as? Data
        guard data != nil else {
            return nil
        }
        return try decoder.decode(T.self, from: data!)
    }

    func save<T: Codable>(_ key: UserDefaultKey, _ value: T?) throws {
        print("UserSettings: save '\(key)' = '\(value ?? ("!nil!" as Any))'")
        if value == nil {
            defaults.set(nil, forKey: key.rawValue)
            return
        }
        let data = try encoder.encode(value)
        defaults.set(data, forKey: key.rawValue)
    }

    func readRx<T: Codable>(_ key: UserDefaultKey) -> Single<T> {
        return Single.create { observer in
            do {
                if let value: T = try self.read(key) {
                    observer(.success(value))
                } else {
                    throw UserDefaultsGatewayError.readingNilValue
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }

    func saveRx<T: Codable>(_ key: UserDefaultKey, _ value: T?) -> Completable {
        return Completable.create { observer in
            do {
                try self.save(key, value)
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}


extension Single {

    func defaultValue(value: Element) -> Single<Element> {
        return asObservable().catchError {
            if $0 is UserDefaultsGatewayError {
                return .just(value)
            }
            return .error($0)
        }.asSingle()
    }
}