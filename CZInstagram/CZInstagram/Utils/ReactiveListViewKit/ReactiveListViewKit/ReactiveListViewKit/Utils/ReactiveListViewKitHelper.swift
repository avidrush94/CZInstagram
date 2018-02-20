//
//  ReactiveListViewKitHelper.swift
//  ReactiveListViewKit
//
//  Created by Cheng Zhang on 11/6/17.
//  Copyright © 2017 Cheng Zhang. All rights reserved.
//

import UIKit
import CZUtils

public func dbgPrint(_ item: CustomStringConvertible) {
    guard ReactiveListViewKit.isDebugMode else { return }
    CZUtils.dbgPrint(item)
}

