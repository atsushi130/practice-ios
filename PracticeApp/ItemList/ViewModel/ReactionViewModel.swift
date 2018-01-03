//
//  ReactionViewModel.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/03.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

enum ReactionViewModel {
    
    case wants
    case haves
    
    typealias IsOn = (wants: Bool, haves: Bool)
    
    func changeState(isOn: IsOn) -> IsOn {
        switch self {
        case .wants: return self.changeWantsState(isOn: isOn)
        case .haves: return self.changeHavesState(isOn: isOn)
        }
    }
    
    private func changeWantsState(isOn: IsOn) -> IsOn {
        switch isOn.haves {
        case true:  return IsOn(wants: true, haves: false)
        case false: return IsOn(wants: !isOn.wants, haves: isOn.haves)
        }
    }
    
    private func changeHavesState(isOn: IsOn) -> IsOn {
        switch isOn.wants {
        case true:  return IsOn(wants: false, haves: true)
        case false: return IsOn(wants: isOn.wants, haves: !isOn.haves)
        }
    }
}
