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
    // Create user with an e-mail and password.
    func createUser(email: String, password: String) -> Single<AuthDataResult> {
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

    // Sign in with e-mail and a link.
    func login(email: String, link: String) -> Single<AuthDataResult> {
        return Single.create { single in
            Auth.auth().signIn(withEmail: email, link: link) { auth, error in
                if let auth = auth {
                    return single(.success(auth))
                } else if let error = error {
                    return single(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    // Update current user.
    func updateCurrentUser(_ user: User) -> Single<Void> {
        return Single.create { single in
            Auth.auth().updateCurrentUser(user) { error in
                guard let error = error else {
                    return single(.success(()))
                }
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
