//
//  UIViewController.swift
//  WebimClientLibrary_Example
//
//  Created by Nikita Lazarev-Zubov on 24.01.18.
//  Copyright © 2018 Webim. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

// MARK: -
extension UIViewController {

    public var isChatViewController: Bool {
        return self is ChatViewController
    }

    public var isImageViewController: Bool {
        return self is WMImageViewController
    }

    public var isFileViewController: Bool {
        return self is WMFileViewController
    }
    
    // MARK: - Methods
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Private methods
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    public func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    static func loadViewControllerFromXib() -> Self {
        let identifier = "\(Self.self)"
        return Self(nibName: identifier, bundle: WidgetAppDelegate.bundle)
    }

    func present(_ viewControllerToPresent: UIViewController, animated: Bool, disableKeyboardNotification: Bool = false, completion: (() -> Void)? = nil) {
        if disableKeyboardNotification {
            disableKeyboardNotificationsIfNeeded()
        }
        present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func disableKeyboardNotificationsIfNeeded() {
        if let viewController = self as? Typeable {
            viewController.keyboardNotificationManager.set(shouldAdjustContentForKeyboard: false)
        }
    }

    func enableKeyboardNotificationsIfNeeded() {
        if let viewController = self as? Typeable {
            viewController.keyboardNotificationManager.set(shouldAdjustContentForKeyboard: true)
        }
    }
}
