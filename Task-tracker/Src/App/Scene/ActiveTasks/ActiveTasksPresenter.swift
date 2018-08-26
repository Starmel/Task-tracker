import Foundation
import RxSwift


protocol ActiveTasksPresenter {

    func viewDidLoad()
}


protocol ActiveTasksView {
}


class ActiveTasksPresenterImp: ActiveTasksPresenter {

    let view: ActiveTasksView
    let router: ActiveTasksRouter

    init(_ view: ActiveTasksView, _ router: ActiveTasksRouter) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
    }
}
