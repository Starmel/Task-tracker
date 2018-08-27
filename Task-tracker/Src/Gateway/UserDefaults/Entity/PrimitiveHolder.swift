//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


struct PrimitiveHolder<T: Codable>: Codable {
    let value: T
}
