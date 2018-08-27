//
// Created by admin on 27.08.2018.
// Copyright (c) 2018 Slava Kornienko. All rights reserved.
//

import UIKit


protocol BaseView: class {
}


extension BaseView {

    func showErrorDialog(message: String,
                         action: ((UIAlertAction) -> Void)? = nil,
                         onShow: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Продолжить",
                                     style: UIAlertActionStyle.default,
                                     handler: action)
        alert.addAction(okAction)
        (self as? UIViewController)?.present(alert, animated: true, completion: onShow)
    }

    func showDialog(message: String, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Хорошо",
                                     style: UIAlertActionStyle.default,
                                     handler: action)
        alert.addAction(okAction)
        (self as? UIViewController)?.present(alert, animated: true)
    }
}