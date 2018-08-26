//
// Created by admin on 15.06.2018.
// Copyright (c) 2018 WebAnt. All rights reserved.
//

import UIKit


class BaseUITableViewController: UITableViewController {

    var isPullToRefreshEnabled: Bool = false {
        didSet {
            if isPullToRefreshEnabled {
                refreshControl?.addTarget(self,
                                          action: #selector(onPullRefresh),
                                          for: .valueChanged)
            } else {
                refreshControl?.removeTarget(self,
                                             action: #selector(onPullRefresh),
                                             for: .valueChanged)
            }
        }
    }

    func enablePullToRefresh() {
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        isPullToRefreshEnabled = true
    }

    @objc func onPullRefresh() {
    }
}