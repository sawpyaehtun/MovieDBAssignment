//
//  UIViewController+Extension.swift
//  MovieAsignWithRealm
//
//  Created by saw pyaehtun on 05/10/2019.
//  Copyright © 2019 saw pyaehtun. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

extension UIViewController {
    func hl_addChildViewController(_ childViewController: UIViewController?, toContainerView containerView: UIView?, removeOtherSubViews: Bool = false, moveupAnimation: Bool = false, animated: Bool = true) {
        guard let childViewController = childViewController, let containerView = containerView else {
            return
        }
        
        addChild(childViewController)
        if !moveupAnimation {
            childViewController.view.alpha = 0
        }
        if removeOtherSubViews {
            containerView.subviews.forEach { subview in
                subview.removeFromSuperview()
            }
        }
        containerView.addSubview(childViewController.view)
        
        childViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
        
        if moveupAnimation {
            childViewController.view.transform = CGAffineTransform.init(translationX: 0, y: childViewController.view.frame.height)
        }
        UIView.animate(withDuration: animated ? 0.4 : 0, animations: {
            childViewController.view.alpha = 1
            childViewController.view.transform = CGAffineTransform.identity
        }, completion: { finished in
            childViewController.didMove(toParent: self)
        })
    }
    
    func hl_removeFromParentViewController(moveupAnimation: Bool = false) {
        willMove(toParent: nil)
        UIView.animate(withDuration: moveupAnimation ? 0.4 : 0.1, animations: {
            if !moveupAnimation {
                self.view.alpha = 0
            }
            if moveupAnimation {
                self.view.transform = CGAffineTransform.init(translationX: 0, y: self.view.frame.height)
            }
        }, completion: { finished in
            self.view.removeFromSuperview()
            //self.removeFromParent()
        })
    }
    
    func hl_childViewControllersWithClass<T : UIViewController>(_ classToFind : T.Type) -> [T] {
        var result = [T]()
        self.children.forEach { candidateVC in
            if candidateVC is T {
                result.append(candidateVC as! T)
            }
        }
        return result
    }
}


extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: false)
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}
