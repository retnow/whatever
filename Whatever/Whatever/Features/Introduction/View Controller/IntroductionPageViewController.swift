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
import SnapKit

final class IntroductionPageViewController: UIPageViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: IntroductionPageViewModel?
    
    // UI elements
    private let pageControl = UIPageControl()
    
    lazy var orderedViewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        viewControllers.append(IntroductionLogoViewController())
        
        viewControllers.append(IntroductionDescriptionViewController(
            title: NSLocalizedString("introduction_outfit_title", comment: ""),
            description: NSLocalizedString("introduction_outfit_description", comment: ""),
            image: UIImage(named: .introductionOutfit)))
        
        viewControllers.append(IntroductionDescriptionViewController(
            title: NSLocalizedString("introduction_life_title", comment: ""),
            description: NSLocalizedString("introduction_life_description", comment: ""),
            image: UIImage(named: .introductionLife)))
        
        viewControllers.append(IntroductionDescriptionViewController(
            title: NSLocalizedString("introduction_closet_title", comment: ""),
            description: NSLocalizedString("introduction_closet_description", comment: ""),
            image: UIImage(named: .introductionCloset)))
        
        return viewControllers
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
        
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break
            }
        }
        
        setupButtons()
        setupNavigationBar()
        
        view.backgroundColor = .clear
    }
    
    // MARK: Helper functions.
    private func setupPageControl() {
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.alpha = 0.8
        pageControl.pageIndicatorTintColor = UIColor(named: .disabled)
        pageControl.currentPageIndicatorTintColor = UIColor(named: .text)
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(480)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(15)
        }
    }
    
    private func setupButtons() {
        let loginButton = PrimaryButton()
        let createAccountButton = SecondaryButton()
        
        // Log in button
        view.addSubview(loginButton)
        loginButton.setTitle(
            NSLocalizedString("login_action", comment: ""),
            for: .normal)
        loginButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(520)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        view.addSubview(createAccountButton)
        createAccountButton.setTitle(
            NSLocalizedString("introduction_create_account", comment: ""),
            for: .normal)
        createAccountButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        // Bind buttons to view model.
        guard let viewModel = viewModel else { return }
        
        loginButton.rx.tap
            .bind { viewModel.loginWasSelected() }
            .disposed(by: disposeBag)
        
        createAccountButton.rx.tap
            .bind { viewModel.createAccountWasSelected() }
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
        navigationBar.shadowImage = UIImage()
    }
}


/// Implementation of page view controller data source and delegate methods.
extension IntroductionPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
            navigationController.setupAsTransparent()
        }
    }
}

/// Implementation of scroll view delegate methods.
extension IntroductionPageViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isScrolledPastLeadingEdge = pageControl.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width
        let isScrolledPastTrailingEdge = pageControl.currentPage == pageControl.numberOfPages - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width
        
        if isScrolledPastLeadingEdge || isScrolledPastTrailingEdge {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let isScrolledPastLeadingEdge = pageControl.currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width
        let isScrolledPastTrailingEdge = pageControl.currentPage == pageControl.numberOfPages - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width
        
        if isScrolledPastLeadingEdge || isScrolledPastTrailingEdge {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
}
