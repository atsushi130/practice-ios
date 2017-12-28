//
//  AccountField.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2017/12/27.
//  Copyright © 2017年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable final class LoginField: UIView {
    
    @IBOutlet fileprivate weak var field: UITextField!
    
    let isValidated = Variable<Bool>(false)
    
    var value: String {
        return self.field.text ?? ""
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get { return self.layer.borderColor?.ex.uiColor }
        set { self.layer.borderColor = newValue?.cgColor }
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return self.field.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        return self.field.resignFirstResponder()
    }
}

extension Reactive where Base: LoginField {
    
    var value: Observable<String> {
        return self.base.field.rx.text.map {
            return $0 ?? ""
        }
    }
    
    /// Bindable sink for `validated` property.
    var isValidated: Binder<Bool> {
        return Binder(self.base) { element, value in
            element.isValidated.value = value
        }
    }
    
    func controlEvent(_ controlEvent: UIControlEvents) -> ControlEvent<()> {
        return self.base.field.rx.controlEvent(controlEvent)
    }
}
