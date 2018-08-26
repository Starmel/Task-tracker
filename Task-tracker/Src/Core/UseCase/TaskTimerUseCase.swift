//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


protocol TaskTimerUseCase {

    func enableTimer(task: TaskEntity)
    func stopTimer(task: TaskEntity)
    func subscribeTimer(task: TaskEntity) -> Observable<TimeInterval>
    func saveAll()
}


class TaskTimerUseCaseImp: TaskTimerUseCase {

    private var activeTasks = [TaskEntity]()
    private var taskGateway: TaskGateway


    init(_ taskGateway: TaskGateway) {
        self.taskGateway = taskGateway
    }

    func enableTimer(task: TaskEntity) {
        if !task.timerInfo.isRunning {
            task.timerInfo.isRunning = true
            task.timerInfo.runTimestamp = Date().timeIntervalSince1970
            activeTasks.append(task)
            _ = taskGateway.addOrUpdate(task).subscribe()
        }
    }

    func stopTimer(task: TaskEntity) {
        if task.timerInfo.isRunning {
            task.timerInfo.updateTotalTime()
            task.timerInfo.isRunning = false
            if let index = activeTasks.index(of: task) {
                activeTasks.remove(at: index)
            }
            _ = taskGateway.addOrUpdate(task).subscribe()
        }
    }

    func subscribeTimer(task: TaskEntity) -> Observable<TimeInterval> {
        return Observable<Int>.interval(1 / 1000, scheduler: MainScheduler.instance)
                .map { _ -> TimeInterval in
                    let pastTime = Date().timeIntervalSince1970 - task.timerInfo.runTimestamp
                    return pastTime + task.timerInfo.totalTime
                }
    }

    func saveAll() {
        activeTasks.forEach { task in
            task.timerInfo.updateTotalTime()
            _ = taskGateway.addOrUpdate(task).subscribe()
        }
    }
}

