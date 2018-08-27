//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


class UserDefaultsTaskGateway: BaseUserDefaultsGateway, TaskGateway {

    private static let TASKS_LIST_KEY = "task_list"


    func addOrUpdate(_ task: TaskEntity) -> Completable {
        return getAll()
                .defaultValue(value: [])
                .flatMapCompletable { (list: [TaskEntity]) -> Completable in
                    var tasks = Set(list)
                    tasks.update(task)
                    return self.saveRx(.tasksList, Array(tasks))
                }
    }

    func getAll() -> Single<[TaskEntity]> {
        return readRx(.tasksList)
    }
}
