//
//  CZHorizontalSectionAdapterCell.swift
//  ReactiveListViewKit
//
//  Created by Cheng Zhang on 1/29/17.
//  Copyright © 2017 Cheng Zhang. All rights reserved.
//

import UIKit
import CZUtils

public class CZHorizontalSectionAdapterCell: UICollectionViewCell, CZFeedCellViewSizeCalculatable {
    fileprivate var viewModel: CZHorizontalSectionAdapterViewModel?
    open var diffId: String { return viewModel?.diffId ?? "" }
    open var onEvent: OnEvent?
    fileprivate var horizontalSectionAdapterView: CZHorizontalSectionAdapterView!
    fileprivate var hasSetup: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsIfNeeded()
    }
    
    public required init(viewModel: CZFeedViewModelable? = nil, onEvent: OnEvent?) {
        self.viewModel = viewModel as? CZHorizontalSectionAdapterViewModel
        self.onEvent = onEvent
        super.init(frame: .zero)
        setupViewsIfNeeded()
        config(with: viewModel)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Should call designated initializer `init(viewModel:onEvent:)`")
    }
    
    public func setupViewsIfNeeded() {
        guard !hasSetup else {return}
        hasSetup = true
        translatesAutoresizingMaskIntoConstraints = false
        horizontalSectionAdapterView = CZHorizontalSectionAdapterView(onEvent: onEvent)
        horizontalSectionAdapterView.overlayOnSuperview(contentView)
    }
    
    public func config(with viewModel: CZFeedViewModelable?) {
        setupViewsIfNeeded()
        guard let viewModel = viewModel as? CZHorizontalSectionAdapterViewModel else {
            return
        }
        isUserInteractionEnabled = true
        contentView.isUserInteractionEnabled = true
        horizontalSectionAdapterView.config(with: viewModel)
    }
    
    public static func sizeThatFits(_ containerSize: CGSize, viewModel: CZFeedViewModelable) -> CGSize {
        return CZHorizontalSectionAdapterView.sizeThatFits(containerSize, viewModel: viewModel)
    }
    
    public func config(with viewModel: CZFeedViewModelable?, prevViewModel: CZFeedViewModelable?) {}
}
