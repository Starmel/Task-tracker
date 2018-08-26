//
//  FirstViewController.swift
//  Task-tracker
//
//  Created by admin on 23.08.2018.
//  Copyright © 2018 Slava Kornienko. All rights reserved.
//

import UIKit


class ActiveTasksViewController: UITableViewController {

    var presenter: ActiveTasksPresenter!


    override func viewDidLoad() {
        super.viewDidLoad()
        ActiveTasksConfiguratorImp().configure(view: self)
        presenter.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presenter.specialSelected(at: indexPath.row)
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
//        presenter.setupItem(cell, indexPath.row)
        return cell
    }

    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .normal, title: "some text",
                                        handler: { (action, view, completionHandler) in
                                            print("ok")
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
                                            print("yo yo")
                                            completionHandler(true)
                                        })

        action.image = UIImage(named: "check")
        action.backgroundColor = .fromHex("66BB6A")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}


extension ActiveTasksViewController: ActiveTasksView {
}
