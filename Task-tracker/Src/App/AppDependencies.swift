//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import DITranquillity


class AppDependencies {

    static let container = DIContainer()


    static func build() {
        container.register(UserDefaults.init)
        container.register1(UserDefaultsTaskGateway.init).as(TaskGateway.self)
    }
}
