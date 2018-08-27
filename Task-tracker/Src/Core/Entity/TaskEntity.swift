//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


class TaskEntity: Codable {

    var timerInfo = TimerInfoEntity()
    var desc: String? = nil


    init(_ isRunning: Bool, _ description: String) {
        self.timerInfo.isRunning = isRunning
        self.desc = description
    }
}


extension TaskEntity: Equatable {

    static func ==(lhs: TaskEntity, rhs: TaskEntity) -> Bool {
        return lhs.desc == rhs.desc;
    }
}


extension TaskEntity: Hashable {

    public var hashValue: Int {
        return desc?.hashValue ?? 0
    }
}


extension TaskEntity: CustomStringConvertible {
    public var description: String {
        return "Task: \(desc), timer: \(timerInfo)\n"
    }
}
