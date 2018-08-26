//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import UIKit


class ActiveCellTaskCell: UITableViewCell, ActiveTaskCell {

    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    func setup(_ task: TaskEntity) {
        statusIcon.image = task.timerInfo.isRunning ? UIImage(named: "pause") : UIImage(named: "play")

        if let desc = task.description {
            descriptionLabel.text = desc
        } else {
            descriptionLabel.text = "Описание не указано"
        }
    }
}
