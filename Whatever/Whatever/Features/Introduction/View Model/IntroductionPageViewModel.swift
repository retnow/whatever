//
//  IntroductionPageViewModel.swift
//  Whatever
//
//  Created by Retno Widyanti on 7/9/19.
//  Copyright © 2019 Retno Widyanti. All rights reserved.
//

import XCoordinator
import RxSwift
import RxCocoa

class IntroductionPageViewModel {
    let router: AnyRouter<IntroductionRoute>
    
    init(router: AnyRouter<IntroductionRoute>) {
        self.router = router
    }
    
    // TODO: Implement router trigger actions.
    func loginWasSelected() {
        
    }
    
    func createAccountWasSelected() {
        
    }
}
