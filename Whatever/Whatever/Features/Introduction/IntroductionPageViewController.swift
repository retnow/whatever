//
//  IntroductionPageViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension String {
    static let outfitTitleText = NSLocalizedString("introduction_outfit_title", comment: "")
    static let outfitDescriptionText = NSLocalizedString("introduction_outfit_description", comment: "")
    static let lifeTitleText = NSLocalizedString("introduction_life_title", comment: "")
    static let lifeDescriptionText = NSLocalizedString("introduction_life_description", comment: "")
    static let closetTitleText = NSLocalizedString("introduction_closet_title", comment: "")
    static let closetDescriptionText = NSLocalizedString("introduction_closet_description", comment: "")
    static let loginButtonTitleText = NSLocalizedString("login_action", comment: "")
    static let createAccountButtonTitleText = NSLocalizedString("create_account_action", comment: "")
}

final class IntroductionPageViewController: UIPageViewController {
    var viewModel: IntroductionPageViewModel?
    
    // UI elements
    private let pageControl = UIPageControl()
    
    lazy var orderedViewControllers: [UIViewController] = {
        var viewControllers = [UIViewController]()
        viewControllers.append(IntroductionLogoViewController())
        
        viewControllers.append(IntroductionDescriptionViewController(
            title: .outfitTitleText,
            description: .outfitDescriptionText,
            image: UIImage(named: .introductionOutfit)))
        
        viewControllers.append(IntroductionDescriptionViewController(
            title: .lifeTitleText,
            description: .lifeDescriptionText,
            image: UIImage(named: .introductionLife)))
        
        viewControllers.append(IntroductionDescriptionViewController(
            title: .closetTitleText,
            description: .closetDescriptionText,
            image: UIImage(named: .introductionCloset)))
        
        return viewControllers
    }()
    
    // Initializers
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(
            transitionStyle: .scroll,
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
        
        // Set the current view controller from page control.
        let currentViewController = orderedViewControllers[pageControl.currentPage]
        setViewControllers(
            [currentViewController],
            direction: .forward,
            animated: true,
            completion: nil)
        
        // Set scroll view delegate in order to prevent bounce behavior.
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
                break
            }
        }
        
        // Hide default back button text by making it an empty string.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        
        // Background color
        view.backgroundColor = UIColor(named: .background)
        
        // Buttons
        let loginButton = PrimaryButton()
        let createAccountButton = SecondaryButton()
        
        view.addSubview(createAccountButton)
        createAccountButton.setTitle(
            .createAccountButtonTitleText,
            for: .normal)
        createAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin).offset(-48)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        createAccountButton.addTarget(
            self,
            action: #selector(createAccountPressed),
            for: .touchUpInside)
        }
        
        view.addSubview(loginButton)
        loginButton.setTitle(
            .loginButtonTitleText,
            for: .normal)
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(createAccountButton.snp.top).offset(-16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        loginButton.addTarget(
            self,
            action: #selector(loginPressed),
            for: .touchUpInside)
        
        // Page control
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(15)
        }
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
    }
    
    @objc
    func loginPressed() {
        viewModel?.loginSelected()
    }
    
    @objc
    func createAccountPressed() {
        viewModel?.createAccountSelected()
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
