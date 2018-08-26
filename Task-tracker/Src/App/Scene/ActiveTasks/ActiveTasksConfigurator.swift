import UIKit
import RxSwift


protocol ActiveTasksConfigurator {

    func configure(view: ActiveTasksViewController)
}


class ActiveTasksConfiguratorImp: ActiveTasksConfigurator {

    func configure(view: ActiveTasksViewController) {
        let router = ActiveTasksRouterImp(view)
        let presenter = ActiveTasksPresenterImp(view, router)
        view.presenter = presenter
    }
}
