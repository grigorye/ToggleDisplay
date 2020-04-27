//
//  CFNumber+CFIndexValue.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import CoreFoundation

extension CFNumber {

    func getCFIndexValue() throws -> CFIndex {
        var cfIndex: CFIndex = 0
        if CFNumberGetValue(self, .cfIndexType, &cfIndex) == false {
            enum Error: Swift.Error {
                case failedCFNumberGetValue(CFNumber)
            }
            throw Error.failedCFNumberGetValue(self)
        }
        return cfIndex
    }
}
