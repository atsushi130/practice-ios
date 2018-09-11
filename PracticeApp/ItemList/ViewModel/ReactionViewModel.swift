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

    func changeState(to reactionState: ReactionState) -> ReactionState {
        switch self {
        case .wants: return self.changeWantsState(reactionState)
        case .haves: return self.changeHavesState(reactionState)
        }
    }
    
    private func changeWantsState(_ reactionState: ReactionState) -> ReactionState {
        switch reactionState.haves {
        case true:  return ReactionState(wants: true, haves: false)
        case false: return ReactionState(wants: !reactionState.wants, haves: reactionState.haves)
        }
    }
    
    private func changeHavesState(_ reactionState: ReactionState) -> ReactionState {
        switch reactionState.wants {
        case true:  return ReactionState(wants: false, haves: true)
        case false: return ReactionState(wants: reactionState.wants, haves: !reactionState.haves)
        }
    }
}
