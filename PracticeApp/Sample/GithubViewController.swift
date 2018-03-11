//
//  SampleViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/03/03.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class GithubViewController: UIViewController {

    fileprivate let selected = PublishSubject<String>()
    fileprivate let text = Variable<String>("")
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct RepositoryModel {}
struct Repository {
    static let shared = Repository()
    func searched(by: String) -> [RepositoryModel] { return [] }
}

final class GithubViewModel: Connectable {
    fileprivate let searchText = Variable<String>("")
    fileprivate let searched   = PublishSubject<[RepositoryModel]>()
    private let disposeBag = DisposeBag()
    init() {
        self.searchText.asObservable()
            .map { Repository.shared.searched(by: $0) }
            .bind(to: self.searched)
            .disposed(by: self.disposeBag)
    }
}

extension InputSpace where Definer == GithubViewModel {
    var searchText: Binder<String> {
        return Binder(self.definer) { element, value in
            element.searchText.value = value
        }
    }
}

extension OutputSpace where Definer == GithubViewModel {
    var searched: Observable<[RepositoryModel]> {
        return self.definer.searched.asObservable()
    }
}
