//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


class TaskEntity {

    var timerInfo = TimerInfoEntity()
    var description: String? = nil


    init(_ isRunning: Bool, _ description: String) {
        self.timerInfo.isRunning = isRunning
        self.description = description
    }
}


extension TaskEntity: Equatable {
    static func ==(lhs: TaskEntity, rhs: TaskEntity) -> Bool {
        return lhs.description == rhs.description;
    }
}
