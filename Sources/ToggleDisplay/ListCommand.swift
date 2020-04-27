//
//  ListCommand.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import Foundation
import ArgumentParser

extension DisplayUtils {

    struct List: ParsableCommand {

        func run() throws {
            for displayID in try queryDisplayIDs() {
                let productNamesValue: Any = {
                    do {
                        return try productNamesForDisplayWithID(displayID)
                    }
                    catch {
                        let mirror = Mirror(reflecting: error).children.first!
                        return [mirror.label!: mirror.value]
                    }
                }()
                print((displayID: displayID, productNamesValue))
            }
        }
    }
}

private func productNamesForDisplayWithID(_ displayID: CGDirectDisplayID) throws -> [String : String] {
    guard let service = try IOServicePortFromCGDisplayID(displayID) else {
        enum Error: Swift.Error {
            case failedServicePortFromDisplayID(CGDirectDisplayID)
        }
        throw Error.failedServicePortFromDisplayID(displayID)
    }

    let deviceInfoUnmanaged = IODisplayCreateInfoDictionary(service, IOOptionBits(kIODisplayOnlyPreferredName))!
    let deviceInfo = deviceInfoUnmanaged.takeUnretainedValue() as! [String : Any]
    let productNames = deviceInfo[kDisplayProductName] as! [String : String]
    return productNames
}

private func queryDisplayIDs() throws -> [CGDirectDisplayID] {

    var estimatedDisplayCount: CGDisplayCount = 0
    try withCGError { CGSGetDisplayList(0, nil, &estimatedDisplayCount) }

    let displayIDs = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: Int(estimatedDisplayCount))
    defer {
        displayIDs.deallocate()
    }

    var displayCount = estimatedDisplayCount
    try withCGError { CGSGetDisplayList(displayCount, displayIDs, &displayCount) }

    return Array(UnsafeMutableBufferPointer(start: displayIDs, count: Int(displayCount)))
}
