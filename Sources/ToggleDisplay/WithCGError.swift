//
//  WithCGError.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import CoreGraphics

func withCGError(block: () -> CGError) throws {
    enum Error: Swift.Error {
        case CoreGraphicsInvocationFailure(CGError)
    }
    let err = block()
    if err != .success {
        enum Error: Swift.Error {
            case failed(CGError)
        }
        throw Error.failed(err)
    }
}
