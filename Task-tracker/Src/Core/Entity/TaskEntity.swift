//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


class TaskEntity {

    var isRunning: Bool = false
    var description: String? = nil


    init(_ isRunning: Bool, _ description: String) {
        self.isRunning = isRunning
        self.description = description
    }
}
