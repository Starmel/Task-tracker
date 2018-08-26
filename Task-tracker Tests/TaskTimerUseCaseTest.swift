//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
@testable import Task_tracker


class TaskTimerUseCaseTest: XCTestCase {


    func test1TotalTimeUpdating() {
        let timer = getTaskTimer()
        let task = createTasks(count: 1)[0]

        timer.enableTimer(task: task)
        sleep(1)
        timer.stopTimer(task: task)

        XCTAssertEqual(false, task.timerInfo.isRunning)
        XCTAssertEqual(1, task.timerInfo.totalTime, accuracy: 0.1)
    }

    func test2SaveAllTasksState() {
        let timer = getTaskTimer()
        let tasks = createTasks(count: 2)

        tasks.forEach { task in
            timer.enableTimer(task: task)
        }
        sleep(1)
        timer.saveAll()
        sleep(1)

        XCTAssertEqual(true, tasks[0].timerInfo.isRunning)
        XCTAssertEqual(true, tasks[1].timerInfo.isRunning)
        XCTAssertEqual(1, tasks[0].timerInfo.totalTime, accuracy: 0.1)
        XCTAssertEqual(1, tasks[1].timerInfo.totalTime, accuracy: 0.1)
    }

    private func getTaskTimer() -> TaskTimerUseCase {
        return TaskTimerUseCaseImp(MockTaskGateway())
    }

    private func createTasks(count: Int) -> [TaskEntity] {
        return Array(repeating: 0, count: count).map({ TaskEntity(false, "task #\($0)") })
    }
}


private class MockTaskGateway: TaskGateway {

    func addOrUpdate(_ task: TaskEntity) -> Completable {
        return Completable.empty()
    }

    func getAll() -> Single<[TaskEntity]> {
        return Single.just([])
    }
}
