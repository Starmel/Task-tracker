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
    func doExportTasks()
    func doCreateTask()
    func saveState()
}


protocol ActiveTasksView: BaseView {

    func refresh()
    func showNewTaskDialog(_ onResult: @escaping (String) -> Void)
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
        doLoadTasks()
    }

    private func doLoadTasks() {
        _ = tasksGateway.getAll().subscribe(onSuccess: { tasks in
            self.tasks = tasks
            self.view.refresh()
        }, onError: { error in
            print("ActiveTasksPresenter: doLoadTasks error", error)
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
        _ = tasksGateway.remove(tasks[at]).subscribe(onCompleted: {
            self.doLoadTasks()
        })
        // TODO 27.08.2018/admin переводить задачу на следующий трекер
    }

    func saveState() {
        taskTimer.saveAll()
    }

    func doCreateTask() {
        view.showNewTaskDialog { desc in
            let task = TaskEntity(false, desc)
            task.timerInfo.createdTimestamp = Date().timeIntervalSince1970
            _ = self.tasksGateway.addOrUpdate(task).subscribe { event in
                self.doLoadTasks()
            }
        }
    }

    func doExportTasks() {
        taskTimer.saveAll()
        _ = tasksGateway.getAll().subscribe(onSuccess: { tasks in
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.allowedUnits = [.hour, .minute, .second]
            formatter.zeroFormattingBehavior = .pad

            let output = tasks.map { task -> String in
                let time = formatter.string(from: task.timerInfo.totalTime) ?? "o_O"
                let date = Date(timeIntervalSince1970: task.timerInfo.createdTimestamp)
                return "Описание: \(task.desc ?? "Не указано"), начата в \(date), длительность \(time)"
            }.joined(separator: "\n")

            UIPasteboard.general.string = output
            self.view.showDialog(message: "Скопировано")
        })
    }
}
