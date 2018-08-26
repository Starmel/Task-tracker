//
// Created by admin on 26.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import UIKit


extension UITableView {

    /// Показывает текст по центру таблицы.
    func emptyMessage(message: String) {
        let sizes: CGSize = bounds.size

        let messageLabel = UILabel(frame: CGRect(x: 0.0,
                                                 y: 0.0,
                                                 width: sizes.width,
                                                 height: sizes.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }


    /// Убирает текст.
    func hideEmptyMessage() {
        self.backgroundView = nil
    }
}
