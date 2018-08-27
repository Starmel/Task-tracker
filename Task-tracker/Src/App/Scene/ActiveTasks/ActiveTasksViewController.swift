//
//  FirstViewController.swift
//  Task-tracker
//
//  Created by admin on 23.08.2018.
//  Copyright © 2018 Slava Kornienko. All rights reserved.
//

import UIKit


class ActiveTasksViewController: BaseUITableViewController {

    var presenter: ActiveTasksPresenter!

    @IBAction func onShareButtonClick(_ sender: Any) {
        presenter.doExportTasks()
    }

    @IBAction func onCreateTaskButtonClick(_ sender: Any) {
        presenter.doCreateTask()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ActiveTasksConfiguratorImp().configure(view: self)
        presenter.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.saveState()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        if presenter.countOfTasks > 0 {
            self.isPullToRefreshEnabled = true
            self.tableView.hideEmptyMessage()
            return 1
        }
        if presenter.isLoadingStatus {
            self.isPullToRefreshEnabled = false
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            self.tableView.backgroundView = activityIndicator;
            self.tableView.separatorStyle = .none;
            activityIndicator.startAnimating()
        } else {
            self.tableView.emptyMessage(message: presenter.emptyListMessage)
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countOfTasks
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return presenter.selectTask(at: indexPath.row)
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell",
                                                 for: indexPath) as! ActiveCellTaskCell
        presenter.setupItem(cell, indexPath.row)
        return cell
    }

    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .normal, title: "some text",
                                        handler: { (action, view, completionHandler) in
                                            self.presenter.showTaskInfo(at: indexPath.row)
                                            completionHandler(true)
                                        })

        action.image = UIImage(named: "info")
        action.backgroundColor = .fromHex("29B6F6")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }

    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "another text",
                                        handler: { (action, view, completionHandler) in
                                            self.presenter.doneTask(at: indexPath.row)
                                            completionHandler(true)
                                        })

        action.image = UIImage(named: "check")
        action.backgroundColor = .fromHex("66BB6A")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}


extension ActiveTasksViewController: ActiveTasksView {

    func refresh() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    func showNewTaskDialog(_ onResult: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Создать", style: .default) { action in
            onResult(alert.textFields![0].text ?? "Без названия")
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { (textField: UITextField!) in
            textField.placeholder = "Описание:"
        })
        self.present(alert, animated: true, completion: nil)
    }
}
