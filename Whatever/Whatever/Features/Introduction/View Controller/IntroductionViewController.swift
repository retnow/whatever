//
//  IntroductionViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class IntroductionPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private let bag = DisposeBag()
    var viewModel: IntroductionPageViewModel?
    private let pageControl = UIPageControl()
    
    lazy var orderedViewControllers: [UIViewController] = {
        var vcArray = [UIViewController]()
        vcArray.append(UIViewController(nibName: "IntroductionLogoViewController", bundle: nil))
        vcArray.append(IntroductionAnimationViewController(nibName: "IntroductionAccountsViewController", bundle: nil, animationName: "Onboarding_paperplane_01"))
        vcArray.append(IntroductionAnimationViewController(nibName: "IntroductionRewardsViewController", bundle: nil, animationName: "Onboarding_paperplane_02"))
        vcArray.append(IntroductionAnimationViewController(nibName: "IntroductionGoalsViewController", bundle: nil, animationName: "Onboarding_paperplane_03"))
        return vcArray
    }()
    
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
        
        // these need to be set before current vc is set
        dataSource = self
        delegate = self
        setupPageControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentViewController = orderedViewControllers[pageControl.currentPage]
        setViewControllers([currentViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        setupNavigationBar()
        setupButtons()
        
        self.view.backgroundColor = .black
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        
        let controller = orderedViewControllers[self.pageControl.currentPage]
        if controller is IntroductionAnimationViewController {
            (controller as! IntroductionAnimationViewController).starAnimation()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(
        pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    private func setupPageControl() {
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.alpha = 0.8
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
        self.pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        // makes navigation bar completely transparent
        navigationController?.navigationBar.makeTransparent()
    }
    
    private func setupButtons() {
        // login button
        let loginButton = UIButton(frame: UIScreen.main.bounds)
        self.view.addSubview(loginButton)
        loginButton.setTitle("EXISTING CUSTOMERS, THIS WAY!", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = FontStyle.getFont(.bodyMedium, ofSize: 14.0)
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        // join now button
        let joinNowButton = UIButton(frame: UIScreen.main.bounds)
        self.view.addSubview(joinNowButton)
        joinNowButton.setTitle("Join now".uppercased(), for: .normal)
        joinNowButton.setTitleColor(.vmaRed, for: .normal)
        joinNowButton.titleLabel?.font = FontStyle.getFont(.bodyMedium, ofSize: 15)
        joinNowButton.layer.cornerRadius = 4.0
        joinNowButton.backgroundColor = .white
        joinNowButton.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-28)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(60)
            // pin to page control
            make.top.equalTo(self.pageControl.snp.bottom).offset(28)
        }
        
        // add right arrow image to join now button
        let buttonImageView = UIImageView(image: UIImage(named: "Right-Arrow-Red"))
        joinNowButton.view.addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints { make -> Void in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-32)
        }
        
        // bind join now button to view model
        guard let viewModel = viewModel else { return }
        
        joinNowButton.rx.tap
            .asObservable()
            .bind(to: viewModel.shouldOnboard)
            .disposed(by: bag)
        
        AppManager.frolloInit
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: self.bag)
        
        // bind login button to view model
        loginButton.rx.tap
            .asObservable()
            .bind(to: viewModel.shouldLogin)
            .disposed(by: bag)
    }
}
