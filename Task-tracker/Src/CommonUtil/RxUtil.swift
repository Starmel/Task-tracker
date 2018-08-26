//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


extension Single {

    static func auto<T>(_ block: @escaping @autoclosure () throws -> T) -> Single<T> {
        return Single.create { observer in
            do {
                let result: T = try block()
                observer(.success(result))
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}


extension PrimitiveSequence where Trait == CompletableTrait {

    static func auto(_ block: @escaping @autoclosure () throws -> Void) -> Completable {
        return Completable.create { observer in
            do {
                try block()
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}