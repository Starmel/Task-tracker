//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


class UserDefaultsTaskGateway: BaseUserDefaultsGateway, TaskGateway {

    func addOrUpdate(_ task: TaskEntity) -> Completable {
        return Completable.empty()
    }

    func getAll() -> Single<[TaskEntity]> {
        return Single.just([])
    }
}
