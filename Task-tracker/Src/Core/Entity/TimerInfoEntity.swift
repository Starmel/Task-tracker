//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation


class TimerInfoEntity {

    var isRunning: Bool = false
    var totalTime: TimeInterval = 0
    var runTimestamp: TimeInterval = 0
    var stopTimestamp: TimeInterval = 0

    func addTime(_ time: TimeInterval) {
        totalTime += time
    }

    func updateTotalTime() {
        let currentTime = Date().timeIntervalSince1970
        let pastTime = currentTime - runTimestamp
        runTimestamp = currentTime
        addTime(pastTime)
    }
}


extension TimerInfoEntity: Equatable {
    static func ==(lhs: TimerInfoEntity, rhs: TimerInfoEntity) -> Bool {
        return lhs.isRunning == rhs.isRunning &&
                lhs.totalTime == rhs.totalTime &&
                lhs.runTimestamp == rhs.runTimestamp &&
                lhs.stopTimestamp == rhs.stopTimestamp;
    }
}
