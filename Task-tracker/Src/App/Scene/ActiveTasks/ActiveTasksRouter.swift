//
// Created by admin on 23.01.18.
// Copyright (c) 2018 WebAnt. All rights reserved.
//

import UIKit


protocol ActiveTasksRouter {
}


class ActiveTasksRouterImp: ActiveTasksRouter {

    let view: ActiveTasksViewController

    init(_ view: ActiveTasksViewController) {
        self.view = view
    }
}
