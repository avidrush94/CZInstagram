//
//  CZFeedModel.swift
//  ReactiveListViewKit
//
//  Created by Cheng Zhang on 1/5/17.
//  Copyright © 2017 Cheng Zhang. All rights reserved.
//

import UIKit

/// NSCopying should be deep copy, so that newViewModel/oldViewModel are comparable
public protocol CZFeedModelable: class, NSObjectProtocol, CZListDiffable, NSCopying {
    var  viewModel: CZFeedViewModelable {get}
    func isEqual(toDiffableObj object: AnyObject) -> Bool
    func copy(with zone: NSZone?) -> Any
}

/// Base building block of CZFeedListView, highly decouples View/ViewModel layers
///
/// Composed of:
/// - viewClass: CZFeedCellViewSizeCalculatable
/// - voewModel: CZFeedViewModelable
///
open class CZFeedModel: NSObject, CZFeedModelable {
    let viewClass: CZFeedCellViewSizeCalculatable.Type
    public let  viewModel: CZFeedViewModelable
    public required init(viewClass: CZFeedCellViewSizeCalculatable.Type, viewModel: CZFeedViewModelable) {
        self.viewClass = viewClass
        self.viewModel = viewModel
        super.init()
    }

    public func isEqual(toDiffableObj object: AnyObject) -> Bool {
        guard let object = object as? CZFeedModel else {
            return false
        }
        return viewClass == object.viewClass &&
            viewModel.isEqual(toDiffableObj: object.viewModel)
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let viewClassCopy = viewClass
        let viewModelCopy = viewModel.copy(with: zone) as! CZFeedViewModelable
        return type(of: self).init(viewClass: viewClassCopy,
                                   viewModel: viewModelCopy)
    }
    
    public func buildView(onEvent: OnEvent?) -> UIView {
        let cellComponent = viewClass.init(viewModel: viewModel, onEvent: onEvent)
        let cellView: UIView
        switch cellComponent {
        case let cellComponent as UICollectionViewCell:
            cellView = cellComponent.contentView
        case let cellComponent as UIView:
            cellView = cellComponent
        case let cellComponent as UIViewController:
            cellView = cellComponent.view
        default:
            fatalError("\(viewClass) isn't expected type!")
            break
        }
        return cellView
    }
}

/// Base building block of CZFeedDetailsView, highly decouples View/ViewModel layers
///
/// Composed of:
/// - viewClass: CZFeedCellViewSizeCalculatable
/// - voewModel: CZFeedViewModelable
///
public class CZFeedDetailsModel: NSObject, CZFeedModelable {
    public let viewClass: CZFeedCellViewable.Type
    public let  viewModel: CZFeedViewModelable
    public required init(viewClass: CZFeedCellViewable.Type, viewModel: CZFeedViewModelable) {
        self.viewClass = viewClass
        self.viewModel = viewModel
        super.init()
    }

    public func isEqual(toDiffableObj object: AnyObject) -> Bool {
        guard let object = object as? CZFeedDetailsModel else {return false}
        return viewClass == object.viewClass &&
               viewModel.isEqual(toDiffableObj: object.viewModel)
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        let viewClassCopy = viewClass
        let viewModelCopy = viewModel.copy(with: zone) as! CZFeedViewModelable
        return type(of: self).init(viewClass: viewClassCopy,
                                   viewModel: viewModelCopy)
    }
}
