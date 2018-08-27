//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


extension Set {

    mutating func update(_ e: Element) {
        if let index = self.index(of: e) {
            self.remove(at: index)
            self.insert(e)
        } else {
            self.insert(e)
        }
    }
}