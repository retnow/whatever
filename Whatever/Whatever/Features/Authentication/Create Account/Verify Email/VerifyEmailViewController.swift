//
//  VerifyEmailViewController.swift
//  Whatever
//
//  Created by Retno Widyanti on 11/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class VerifyEmailViewController: AppViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: Heading2!
    @IBOutlet weak var messageLabel: Body!
    @IBOutlet weak var continueButton: PrimaryButton!

    var viewModel: VerifyEmailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        // String constants.
        titleLabel.text = NSLocalizedString("verify_email_title", comment: "")

        continueButton.setTitle(
            NSLocalizedString("verify_email_button", comment: ""),
            for: .normal)
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }

        continueButton.rx.tap
            .subscribe(onNext: viewModel.continueSelected)
            .disposed(by: disposeBag)

        // Render screen when new view state is received.
        viewModel.state
            .subscribe(onNext: { [weak self] in self?.render($0) })
            .disposed(by: disposeBag)
    }

    // Render correct elements depending on current state.
    private func render(_ state: VerifyEmailViewState) {
        switch state {
        case .initial:
            break
        case .loaded(let email):
            messageLabel.setText(
                to: String.localizedStringWithFormat(
                    NSLocalizedString("verify_email_message", comment: ""),
                    email),
                withLineHeightMultiple: 1.25)
        }
    }

}
