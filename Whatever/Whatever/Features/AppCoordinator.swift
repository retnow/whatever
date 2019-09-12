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

        // Listen to change in authentication state to deal with session timeout and logout.
        AppManager.shared.authentication.authenticated
            .drive(onNext: { [weak self] state in
                guard let self = self else { return }
                self.rootViewController.dismiss(animated: true)
                switch state {
                case .loggedIn(_):
                    self.anyRouter.trigger(.login)
                case .loggedOut:
                    break
                }
            })
            .disposed(by: disposeBag)
    }

    override func generateRootViewController() -> UIViewController {
        let viewController = AppViewController()
        return viewController
    }

    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {

        // TODO: Skip introduction for existing user.
        case .introduction:
            let authenticationCoordinator = AuthenticationCoordinator()
            return .embed(
                authenticationCoordinator,
                in: self.rootViewController)

        // TODO: Handle reauthentication for logged in existing user.
        case .login:
            let loginRouter = AuthenticationCoordinator().anyRouter
            return .embed(
                loginRouter,
                in: self.rootViewController,
                style: .present)

        case .logout:
            let loginRouter = AuthenticationCoordinator().anyRouter
            return .embed(
                loginRouter,
                in: self.rootViewController,
                style: .dismiss)
        }
    }
}

/// Define custom 'embed' transitions for present/dismiss.
fileprivate extension Transition {
    enum EmbedStyle {
        case present
        case dismiss
    }

    static func embed(
        _ presentable: Presentable,
        in container: Container,
        style: EmbedStyle) -> Transition {
        switch style {
        case .present:
            return Transition(
                presentables: [presentable],
                animationInUse: nil) { root, options, completion in
                root.embedPresent(
                    presentable.viewController,
                    in: container,
                    with: options) {
                    presentable.presented(from: root)
                    completion?()
                }
            }

        case .dismiss:
            return Transition(
                presentables: [presentable],
                animationInUse: nil) { root, options, completion in
                root.embedDismiss(
                    presentable.viewController,
                    in: container, with: options) {
                    presentable.presented(from: root)
                    completion?()
                }
            }
        }
    }
}

fileprivate extension UIViewController {
    func embedPresent(
        _ viewController: UIViewController,
        in container: Container,
        with options: TransitionOptions,
        completion: PresentationHandler?) {
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

        container.view!.snp.makeConstraints { make in
            make.leading.equalTo(viewController.view)
            make.trailing.equalTo(viewController.view)
            make.top.equalTo(viewController.view)
            make.bottom.equalTo(viewController.view)
        }

        viewController.didMove(toParent: container.viewController)
        completion?()
    }

    func embedDismiss(
        _ viewController: UIViewController,
        in container: Container,
        with options: TransitionOptions, completion: PresentationHandler?) {
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

        container.view!.snp.makeConstraints { make in
            make.leading.equalTo(viewController.view)
            make.trailing.equalTo(viewController.view)
            make.top.equalTo(viewController.view)
            make.bottom.equalTo(viewController.view)
        }

        viewController.didMove(toParent: container.viewController)
    }
}
