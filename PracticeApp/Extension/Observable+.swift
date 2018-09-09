//
//  Observable+.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    var discarded: Observable<()> {
        return self.fill(())
    }
    
    func fill<A>( _ value: A) -> Observable<A> {
        return self.map { _ in value }
    }
}
