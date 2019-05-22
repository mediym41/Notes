//
//  Localization.swift
//  app
//
//  Created by Mediym on 4/15/19.
//  Copyright © 2019 ikar. All rights reserved.
//

import Foundation

public func s(_ key: String) -> String  {
    return NSLocalizedString(key, comment: "")
}

public func s(_ key: String, _ value: String) -> String  {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, value)
}

public func n(_ key: String, count: Int) -> String {
    return String.localizedStringWithFormat(key, count)
    
}

