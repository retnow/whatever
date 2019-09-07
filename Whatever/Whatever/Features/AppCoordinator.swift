//
//  AppCoordinator.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

enum AppRoute: Route {
    case introduction
    case login
    case logout
}

class AppCoordinator: ViewCoordinator<AppRoute> {
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(initialRoute: .introduction)
        
        // TODO: Listen to change in authentication state to deal with session timeout and logout.
    }
    
    override func generateRootViewController() -> UIViewController {
        let viewController = AppViewController()
        return viewController
    }
    
    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {
            
        case .introduction:
            let introductionRouter = IntroductionCoordinator(superRouter: anyRouter).anyRouter
            return .embed(introductionRouter, in: self.rootViewController)
            
        // TODO: Handle reauthentication for logged in existing user.
        case .login:
            let loginRouter = LoginCoordinator().anyRouter
            return .embed(loginRouter, in: self.rootViewController, style: .present)
  
        case .logout:
            let loginRouter = LoginCoordinator().anyRouter
            return .embed(loginRouter, in: self.rootViewController, style: .dismiss)
        }
    }
}

/// Define custom 'embed' transitions for present/dismiss.
fileprivate extension Transition {
    enum EmbedStyle {
        case present
        case dismiss
    }
    
    static func embed(_ presentable: Presentable, in container: Container, style: EmbedStyle) -> Transition {
        switch style {
        case .present:
            return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, options, completion in rootViewController.embedPresent(presentable.viewController, in: container, with: options) {
                    presentable.presented(from: rootViewController)
                    completion?()
                }
            }
            
        case .dismiss:
            return Transition(presentables: [presentable], animationInUse: nil) { rootViewController, options, completion in
                rootViewController.embedDismiss(presentable.viewController, in: container, with: options) {
                    presentable.presented(from: rootViewController)
                    completion?()
                }
            }
        }
    }
}

fileprivate extension UIViewController {
    func embedPresent(_ viewController: UIViewController, in container: Container, with options: TransitionOptions, completion: PresentationHandler?) {
        container.viewController.addChild(viewController)
        container.view.addSubview(viewController.view)
        
        // First set starting frame y-position as bottom-most point.
        viewController.view.frame.origin.y += viewController.view.frame.height
        
        // Animate frame moving to top-most point.
        UIView.setAnimationCurve(.easeInOut)
        UIView.animate(withDuration: 0.5, animations: {
            viewController.view.frame.origin.y = 0
        }, completion: { _ in
            let firstChild = container.viewController.children.first
            firstChild?.removeFromParent()
            firstChild?.view.removeFromSuperview()
        })
        
        NSLayoutConstraint.activate([NSLayoutConstraint(
            item: container.view!,
            attribute: .leading,
            relatedBy: .equal,
            toItem: viewController.view,
            attribute: .leading,
            multiplier: 1,
            constant: 0),
                                     NSLayoutConstraint(item: container.view!, attribute: .trailing, relatedBy: .equal, toItem: viewController.view, attribute: .trailing, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: container.view!, attribute: .top, relatedBy: .equal, toItem: viewController.view, attribute: .top, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: container.view!, attribute: .bottom, relatedBy: .equal, toItem: viewController.view, attribute: .bottom, multiplier: 1, constant: 0)
            ])
        
        viewController.didMove(toParent: container.viewController)
        completion?()
    }
    
    func embedDismiss(_ viewController: UIViewController, in container: Container, with options: TransitionOptions, completion: PresentationHandler?) {
        let fromImageView = UIImageView(image: container.view.convertToImage())
        
        for child in container.viewController.children {
            child.removeFromParent()
            child.view.removeFromSuperview()
        }
        
        container.view.addSubview(viewController.view)
        container.view.sendSubviewToBack(viewController.view)
        container.viewController.addChild(viewController)
        
        viewController.view.addSubview(fromImageView)
        
        UIView.setAnimationCurve(.easeInOut)
        UIView.animate(
            withDuration: 0.5,
            animations: {
                fromImageView.frame.origin.y += fromImageView.frame.height
        },
            completion: { _ in
                fromImageView.removeFromSuperview()
        })
        
        NSLayoutConstraint.activate([NSLayoutConstraint(item: container.view!, attribute: .leading, relatedBy: .equal, toItem: viewController.view, attribute: .leading, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: container.view!, attribute: .trailing, relatedBy: .equal, toItem: viewController.view, attribute: .trailing, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: container.view!, attribute: .top, relatedBy: .equal, toItem: viewController.view, attribute: .top, multiplier: 1, constant: 0),
                                     NSLayoutConstraint(item: container.view!, attribute: .bottom, relatedBy: .equal, toItem: viewController.view, attribute: .bottom, multiplier: 1, constant: 0)
            ])
        
        viewController.didMove(toParent: container.viewController)
    }
}
