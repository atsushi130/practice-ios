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
import RxDataSources
import CoordinatorKit

final class ItemDetailViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.ex.register(cellType: ItemDetailFoldersCell.self)
            self.collectionView.ex.register(cellType: ItemCell.self)
            self.collectionView.ex.register(reusableViewType: ItemDetailReusableView.self)
            self.collectionView.ex.register(reusableViewType: LabelReusableView.self)
        }
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        // self sizing by autolayout
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize   = CGSize(width: 1.0, height: 1.0)
        layout.headerReferenceSize = CGSize(width: 1.0, height: 1.0)
        layout.sectionInset        = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing      = 10
        layout.minimumInteritemSpacing = 10
        return layout
    }()
    
    private struct Section {
        static let detail = 0
        static let folder = 1
        static let item   = 2
        static let count  = 3
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel  = ItemDetailViewModel()
    
    private lazy var dataSource = {
        return RxCollectionViewSectionedReloadDataSource<ItemDetailSectionModel>(
            configureCell: { (dataSource, _, indexPath, sectionItem) in
                switch (dataSource[indexPath.section], sectionItem) {
                case let (.normalSection, .normalItem(item)):
                    let cell = self.collectionView.ex.dequeueReusableCell(with: ItemCell.self, for: indexPath)
                    cell.bind(item: item)
                    cell.rx.updateReaction
                        .map { item in return (item, indexPath.row) }
                        .bind(to: self.viewModel.in.item)
                        .disposed(by: cell.disposeBag)
                    let inset  = self.layout.sectionInset
                    let margin = self.layout.minimumInteritemSpacing + inset.left + inset.right
                    cell.cellWidth = (self.collectionView.frame.size.width - margin).ex.half.ex.floor
                    return cell
                case (.folderSection, .folderItem):
                    let cell = self.collectionView.ex.dequeueReusableCell(with: ItemDetailFoldersCell.self, for: indexPath)
                    cell.cellWidth = self.collectionView.frame.width
                    return cell
                default: return ItemCell()
                }
            },
            configureSupplementaryView: { (dataSource, _, kind, indexPath) in
                switch dataSource[indexPath.section] {
                case .detailSection:
                    let header = self.collectionView.ex.dequeueReusableView(with: ItemDetailReusableView.self, for: indexPath)
                    
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
                    
                case .folderSection(_, let title):
                    let header = self.collectionView.ex.dequeueReusableView(with: LabelReusableView.self, for: indexPath)
                    header.text = title
                    return header
                    
                case .normalSection(_, let title):
                    let header = self.collectionView.ex.dequeueReusableView(with: LabelReusableView.self, for: indexPath)
                    header.text = title
                    return header
                }
            }
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        self.viewModel.out.updateItems
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}

extension ItemDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch self.dataSource[section] {
        case .detailSection: return CGSize(width: collectionView.frame.size.width, height: 946)
        case .normalSection,
             .folderSection: return CGSize(width: collectionView.frame.size.width, height: 40)
        }
    }
}

