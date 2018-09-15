//
//  Observable+.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import Foundation
import RxSwift

public extension Observable {
    public var discarded: Observable<()> {
        return self.fill(())
    }
    
    public func fill<A>( _ value: A) -> Observable<A> {
        return self.map { _ in value }
    }
}
