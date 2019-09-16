//
//  AuthenticationRepository.swift
//  Whatever
//
//  Created by Widyanti, Retno (AU - Melbourne) on 12/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import RxSwift
import FirebaseAuth

class AuthenticationRepository {
    // MARK: Create account
    // Create user with an e-mail and password.
    public func createUser(
        email: String,
        password: String) -> Single<AuthDataResult> {
        return Single.create { single in
            Auth.auth().createUser(
                withEmail: email,
                password: password) { auth, error in
                if let auth = auth {
                    return single(.success(auth))
                } else if let error = error {
                    return single(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    // Send verification e-mail.
    public func sendVerificationEmail() -> Completable {
        return Completable.create { completable in
            Auth.auth().currentUser?.sendEmailVerification() { error in
                guard let error = error else {
                    return completable(.completed)
                }
                return completable(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: Login
    public func login(
        email: String,
        password: String) -> Single<AuthDataResult> {
        return Single.create { single in
            Auth.auth().signIn(
            withEmail: email,
            password: password) { auth, error in
                if let error = error {
                    return single(.error(error))
                } else if let auth = auth {
                    return single(.success(auth))
                }
            }
            return Disposables.create()
        }
    }

    // MARK: Update account
    // Update user profile with display name.
    public func updateProfile(displayName: String) -> Completable {
        return Completable.create { completable in
            let request = Auth.auth().currentUser?.createProfileChangeRequest()
            request?.displayName = displayName
            request?.commitChanges { (error) in
                guard let error = error else {
                    return completable(.completed)
                }
                return completable(.error(error))
            }
            return Disposables.create()
        }
    }

    // Update current user.
    public func updateCurrentUser(_ user: User) -> Completable {
        return Completable.create { completable in
            Auth.auth().updateCurrentUser(user) { error in
                guard let error = error else {
                    return completable(.completed)
                }
                completable(.error(error))
            }
            return Disposables.create()
        }
    }

    // MARK: Password reset
    public func sendPasswordReset(email: String) -> Completable {
        return Completable.create { completable in
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                guard let error = error else {
                    return completable(.completed)
                }
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
}
