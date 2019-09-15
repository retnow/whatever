//
//  AuthenticationManager.swift
//  Whatever
//
//  Created by Widyanti, Retno (AU - Melbourne) on 12/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import RxSwift
import RxCocoa

enum AuthenticationResult {
    case success(newUser: Bool)
    case emailUnverified
    case wrongCredentials
    case error
}

enum AuthenticatedState {
    case loggedIn(newUser: Bool)
    case loggedOut
}

final class AuthenticationManager {
    private let disposeBag = DisposeBag()

    // Variable exposing authentication state.
    private(set) lazy var authenticated = self.authenticatedSubject
        .asDriver(onErrorJustReturn: .loggedOut)
    let authenticatedSubject = PublishSubject<AuthenticatedState>()

    // Repository.
    private let authenticationRepository = AuthenticationRepository()

    // MARK: Network calls.
    func createUser(
        name: String,
        email: String,
        password: String) -> Single<AuthenticationResult> {
        return authenticationRepository.createUser(
            email: email,
            password: password)
            .flatMapCompletable({ result in
                return self.authenticationRepository.updateProfile(
                    displayName: name)})
            .andThen(.just(.success(newUser: true)))
            .catchErrorJustReturn(.error)
    }
    
    func login(
        email: String,
        password: String) -> Single<AuthenticationResult> {
        return authenticationRepository.login(
            email: email,
            password: password)
            .flatMap { auth in
                if auth.user.isEmailVerified {
                    return .just(.success(newUser: true))
                }
                return .just(.emailUnverified)
            }
            .catchErrorJustReturn(.wrongCredentials)
    }
}
