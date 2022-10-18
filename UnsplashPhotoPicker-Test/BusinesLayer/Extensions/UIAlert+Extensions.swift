//
//  UIAlert+Extensions.swift
//
//  Created by Shuhrat Nurov on 10/07/22.
//

import UIKit

extension UIAlertAction {
    
    @objc convenience init(highlited title: String?, handler: ((UIAlertAction) -> Void)?) {
        self.init(title: title, style: .default, handler: handler)
        makeHighlitedAction()
    }
    
    func makeHighlitedAction() {
        setValue(UIColor.systemBlue, forKey: "titleTextColor")
    }
    
}
