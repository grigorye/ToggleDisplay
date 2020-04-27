//
//  WithKernReturn.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import Darwin.Mach.machine

func withKernReturn(block: () -> kern_return_t) throws {
    let err = block()
    if err != 0 {
        enum Error: Swift.Error {
            case kernReturn(kern_return_t)
        }
        throw Error.kernReturn(err)
    }
}
