//
//  IntroductionPageViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class IntroductionPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private let disposeBag = DisposeBag()
    
    var viewModel: IntroductionPageViewModel?
    
    // UI elements
    private let pageControl = UIPageControl()
    let loginButton = PrimaryButton(frame: UIScreen.main.bounds)
    lazy var orderedViewControllers: [UIViewController] = {
        var vcArray = [UIViewController]()
        vcArray.append(IntroductionLogoViewController())
        return vcArray
    }()
    
    // Initializers
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        // These need to be set before current view controller is set.
        dataSource = self
        delegate = self
        
        setupPageControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentViewController = orderedViewControllers[pageControl.currentPage]
        setViewControllers(
            [currentViewController],
            direction: .forward,
            animated: true,
            completion: nil)
        
        setupButtons()
    }
    
    private func setupPageControl() {
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 0.8
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
    private func setupButtons() {
        // TODO: Setup buttons.
    }
}

extension IntroductionPageViewController {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(
            of: pageContentViewController)!
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(
            of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0,
            orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(
            of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex,
            orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(
        pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(
        pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(
                of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}

/// Implementation of navigation controller delegate methods.
extension IntroductionPageViewController: UINavigationControllerDelegate {
    // Format navigation bar depending on type of view controller.
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
        
        if let navigationController = navigationController as? NavigationController {
            if type(of: viewController) == IntroductionPageViewController.self {
                navigationController.setupAsTransparent()
            }
            else {
                navigationController.setup()
            }
        }
    }
}
