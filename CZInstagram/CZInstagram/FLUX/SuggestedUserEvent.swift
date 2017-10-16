//
//  SuggestedUserEvent.swift
//  CZInstagram
//
//  Created by Cheng Zhang on 3/28/17.
//  Copyright © 2017 Cheng Zhang. All rights reserved.
//

import UIKit
import ReactiveListViewKit

enum SuggestedUserEvent: Event {
    case follow(user: User)
    case ignore(user: User)        
}
