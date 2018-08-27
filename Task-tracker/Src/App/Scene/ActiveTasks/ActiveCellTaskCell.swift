//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import UIKit
import RxSwift


class ActiveCellTaskCell: UITableViewCell, ActiveTaskCell {

    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private var disposeBag = DisposeBag()


    func setup(_ task: TaskEntity) {
        statusIcon.image = task.timerInfo.isRunning ? UIImage(named: "pause") : UIImage(named: "play")

        if let desc = task.desc {
            descriptionLabel.text = desc
        } else {
            descriptionLabel.text = "Описание не указано"
        }

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad

        task.timerInfo.timerUpdate()
                .subscribe(onNext: { [weak self] timestamp in
                    self?.timeLabel.text = formatter.string(from: timestamp)
                })
                .disposed(by: disposeBag)
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        disposeBag = DisposeBag()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
