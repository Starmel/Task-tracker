import UIKit
import RxSwift
import DITranquillity


protocol ActiveTasksConfigurator {

    func configure(view: ActiveTasksViewController)
}


class ActiveTasksConfiguratorImp: ActiveTasksConfigurator {

    func configure(view: ActiveTasksViewController) {
        let tasksGateway: TaskGateway = AppDependencies.resolve()
        let taskTimer: TaskTimerUseCase = AppDependencies.resolve()
        let router = ActiveTasksRouterImp(view)
        let presenter = ActiveTasksPresenterImp(view, router, tasksGateway, taskTimer)
        view.presenter = presenter
    }
}
