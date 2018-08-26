import UIKit
import RxSwift
import DITranquillity


protocol ActiveTasksConfigurator {

    func configure(view: ActiveTasksViewController)
}


class ActiveTasksConfiguratorImp: ActiveTasksConfigurator {

    func configure(view: ActiveTasksViewController) {
        let tasksGateway: TaskGateway = AppDependencies.container.resolve()
        let router = ActiveTasksRouterImp(view)
        let presenter = ActiveTasksPresenterImp(view, router, tasksGateway)
        view.presenter = presenter
    }
}
