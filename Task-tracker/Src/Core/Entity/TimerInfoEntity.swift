//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


class TimerInfoEntity: Codable {

    var isRunning: Bool = false
    var totalTime: TimeInterval = 0
    var runTimestamp: TimeInterval = 0
    var stopTimestamp: TimeInterval = 0


    func addTime(_ time: TimeInterval) {
        totalTime += time
    }

    func updateTotalTime() {
        let currentTime = Date().timeIntervalSince1970
        let pastTime = runTimestamp != 0 ? currentTime - runTimestamp : 0
        runTimestamp = currentTime
        addTime(pastTime)
    }

    func elapsedTime() -> TimeInterval {
        if isRunning {
            let pastTime = runTimestamp != 0 ? Date().timeIntervalSince1970 - runTimestamp : 0
            return pastTime + totalTime
        } else {
            return totalTime
        }
    }

    func timerUpdate() -> Observable<TimeInterval> {
        return Observable<Int>.interval(1 / 1000, scheduler: MainScheduler.instance)
                .map { _ in self.elapsedTime() }
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


extension TimerInfoEntity: Hashable {

    public var hashValue: Int {
        return isRunning.hashValue ^
                totalTime.hashValue ^
                runTimestamp.hashValue ^
                stopTimestamp.hashValue
    }
}


extension TimerInfoEntity: CustomStringConvertible {

    public var description: String {
        return "isRunning \(isRunning), totalTime \(totalTime), runTimestamp \(Date(timeIntervalSince1970: runTimestamp)), stopTimestamp \(Date(timeIntervalSince1970: stopTimestamp))"
    }
}
