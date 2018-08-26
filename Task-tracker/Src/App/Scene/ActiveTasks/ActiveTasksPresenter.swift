import Foundation
import RxSwift


protocol ActiveTasksPresenter {

    var countOfTasks: Int { get }
    var isLoadingStatus: Bool { get }
    var emptyListMessage: String { get }
    func viewDidLoad()
    func setupItem(_ cell: ActiveTaskCell, _ row: Int)
    func selectTask(at: Int)
    func showTaskInfo(at: Int)
    func doneTask(at: Int)
}


protocol ActiveTasksView {
    func refresh()
}


protocol ActiveTaskCell {
    func setup(_ task: TaskEntity)
}


class ActiveTasksPresenterImp: ActiveTasksPresenter {

    private let view: ActiveTasksView
    private let router: ActiveTasksRouter
    private let tasksGateway: TaskGateway
    private var tasks = [TaskEntity]()
    private(set) var isLoadingStatus: Bool = false
    private(set) var emptyListMessage: String = "Ого! У кого-то нет задач"
    var countOfTasks: Int {
        return tasks.count
    }


    init(_ view: ActiveTasksView, _ router: ActiveTasksRouter, _ tasksGateway: TaskGateway) {
        self.view = view
        self.router = router
        self.tasksGateway = tasksGateway
    }

    func viewDidLoad() {
        _ = tasksGateway.getAll().subscribe(onSuccess: { tasks in
            self.tasks = tasks
            self.view.refresh()
        }, onError: { error in
        })
    }

    func setupItem(_ cell: ActiveTaskCell, _ row: Int) {
        cell.setup(tasks[row])
    }

    func selectTask(at: Int) {
    }

    func showTaskInfo(at: Int) {
    }

    func doneTask(at: Int) {
    }
}
