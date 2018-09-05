//
//  ItemDetailViewController.swift
//  PracticeApp
//
//  Created by Atsushi Miyake on 2018/01/04.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ItemDetailViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.layout = UICollectionViewFlowLayout()
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.ex.register(cellType: ItemDetailFoldersCell.self)
            self.collectionView.ex.register(cellType: ItemCell.self)
            self.collectionView.ex.register(reusableViewType: ItemDetailReusableView.self)
            self.collectionView.ex.register(reusableViewType: LabelReusableView.self)
        }
    }
    
    private var layout: UICollectionViewFlowLayout! = UICollectionViewFlowLayout() {
        didSet {
            // self sizing by autolayout
            self.layout.estimatedItemSize   = CGSize(width: 1.0, height: 1.0)
            self.layout.headerReferenceSize = CGSize(width: 1.0, height: 1.0)
            self.layout.sectionInset        = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            self.layout.minimumLineSpacing      = 10
            self.layout.minimumInteritemSpacing = 10
        }
    }
    
    private struct Section {
        static let detail = 0
        static let folder = 1
        static let item   = 2
        static let count  = 3
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel  = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.out.updateItems
            .drive(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.fetch()
    }
    
    deinit {
        print("item detail view controller deinit")
    }
}

// MARK: - UICollectionViewDelegate
extension ItemDetailViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.count
    }
}

// MARK: - UICollectionViewDataSource
extension ItemDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case Section.detail: return 0
        case Section.folder: return 1
        case Section.item:   return self.viewModel.items.value.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case Section.item:
            let cell = collectionView.ex.dequeueReusableCell(with: ItemCell.self, for: indexPath)
            cell.bind(item: self.viewModel.items.value[indexPath.row])
            cell.rx.updateReaction
                .map { item in return (item, indexPath.row) }
                .bind(to: self.viewModel.in.item)
                .disposed(by: cell.disposeBag)
            
            let inset  = self.layout.sectionInset
            let margin = self.layout.minimumInteritemSpacing + inset.left + inset.right
            cell.cellWidth = (self.collectionView.frame.size.width - margin).ex.half.ex.floor
            return cell
            
        default:
            let cell = collectionView.ex.dequeueReusableCell(with: ItemDetailFoldersCell.self, for: indexPath)
            cell.cellWidth = self.collectionView.frame.width
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch indexPath.section {
        case Section.detail:
            let header = collectionView.ex.dequeueReusableView(with: ItemDetailReusableView.self, for: indexPath)
            
            let updateConstraints = { [weak self] in
                guard let `self` = self else { return }
                let offsetY    = self.collectionView.contentOffset.y
                let hideHeight = 34.0 as CGFloat
                let threshold  = header.frame.size.height - self.view.frame.size.height + self.view.ex.safeAreaInsets.bottom
                let offset     = offsetY <= threshold ? threshold - offsetY - hideHeight : -hideHeight
                header.reactionFooterView.snp.updateConstraints { make in
                    make.bottom.equalTo(header.snp.bottom).offset(-offset)
                }
            }
            
            // initial
            updateConstraints()
            
            self.collectionView.rx.didScroll.asDriver()
                .drive(onNext: {
                    updateConstraints()
                })
                .disposed(by: header.disposeBag)
            
            header.rx.willSegueToUserList.asDriver()
                .drive(onNext: { [weak self] reactionType in
                    let storyboard = UIStoryboard(name: UserListViewController.ex.className, bundle: nil)
                    let userListViewController = storyboard.instantiateInitialViewController() as! UserListViewController
                    userListViewController.navigationItem.title = reactionType == .wants ? "wantしている人" : "haveしている人"
                    self?.navigationController?.pushViewController(userListViewController, animated: true)
                })
                .disposed(by: header.disposeBag)
            
            return header
            
        case Section.folder:
            let header = collectionView.ex.dequeueReusableView(with: LabelReusableView.self, for: indexPath)
            header.text = "このアイテムが含まれるフォルダ"
            return header
            
        default:
            let header = collectionView.ex.dequeueReusableView(with: LabelReusableView.self, for: indexPath)
            header.text = "関連アイテム"
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: ItemDetailViewController.ex.className, bundle: nil)
        let itemDetailViewController = storyboard.instantiateInitialViewController() as! ItemDetailViewController
        self.navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:  return CGSize(width: collectionView.frame.size.width, height: 946)
        default: return CGSize(width: collectionView.frame.size.width, height: 40)
        }
    }
}

