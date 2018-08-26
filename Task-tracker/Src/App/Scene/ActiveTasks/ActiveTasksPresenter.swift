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
    func saveState()
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
    private let taskTimer: TaskTimerUseCase
    private var tasks = [TaskEntity]()
    private(set) var isLoadingStatus: Bool = false
    private(set) var emptyListMessage: String = "Ого! У кого-то нет задач"
    var countOfTasks: Int {
        return tasks.count
    }


    init(_ view: ActiveTasksView,
         _ router: ActiveTasksRouter,
         _ tasksGateway: TaskGateway,
         _ taskTimer: TaskTimerUseCase) {
        self.view = view
        self.router = router
        self.tasksGateway = tasksGateway
        self.taskTimer = taskTimer
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
        let task = tasks[at]
        if task.timerInfo.isRunning {
            taskTimer.stopTimer(task)
        } else {
            taskTimer.enableTimer(task)
        }
        view.refresh()
    }

    func showTaskInfo(at: Int) {
        // TODO 27.08.2018/admin открывать инфомаицю с подрброной ифнформацией
    }

    func doneTask(at: Int) {
        // TODO 27.08.2018/admin переводить задачу на следующий трекер
    }

    func saveState() {
        taskTimer.saveAll()
    }
}
