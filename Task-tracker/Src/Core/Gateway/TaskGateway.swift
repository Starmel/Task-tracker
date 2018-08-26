//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import Foundation
import RxSwift


protocol TaskGateway {

    func addOrUpdate(_ task: TaskEntity) -> Completable

    func getAll() -> Single<[TaskEntity]>
}
