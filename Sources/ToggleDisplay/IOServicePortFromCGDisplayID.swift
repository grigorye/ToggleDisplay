//
//  IOServicePortFromCGDisplayID.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import CoreGraphics
import IOKit

func IOServicePortFromCGDisplayID(_ displayID: CGDirectDisplayID) throws -> io_service_t? {

    let matching = IOServiceMatching("IODisplayConnect")

    var iterator: io_iterator_t = 0
    try withKernReturn { IOServiceGetMatchingServices(kIOMasterPortDefault, matching, &iterator) }
    defer {
        IOObjectRelease(iterator)
    }

    while let service = IOIteratorNext(iterator) as io_service_t?, service != 0 {
        let infoUnmanaged = IODisplayCreateInfoDictionary(service, IOOptionBits(kIODisplayOnlyPreferredName))
        defer {
            infoUnmanaged?.release()
        }
        let info = infoUnmanaged?.takeUnretainedValue() as! [String: Any]

        let vendorID = try (info[kDisplayVendorID] as! CFNumber).getCFIndexValue()
        let productID = try (info[kDisplayProductID] as! CFNumber).getCFIndexValue()

        if CGDisplayVendorNumber(displayID) == vendorID && CGDisplayModelNumber(displayID) == productID {
            return service
        }
    }

    return nil
}
