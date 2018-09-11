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

    func changeState(reaction: Reaction) -> Reaction {
        switch self {
        case .wants: return self.changeWantsState(reaction: reaction)
        case .haves: return self.changeHavesState(reaction: reaction)
        }
    }
    
    private func changeWantsState(reaction: Reaction) -> Reaction {
        switch reaction.haves {
        case true:  return Reaction(wants: true, haves: false)
        case false: return Reaction(wants: !reaction.wants, haves: reaction.haves)
        }
    }
    
    private func changeHavesState(reaction: Reaction) -> Reaction {
        switch reaction.wants {
        case true:  return Reaction(wants: false, haves: true)
        case false: return Reaction(wants: reaction.wants, haves: !reaction.haves)
        }
    }
}
