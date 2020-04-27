//
//  CoreGraphicsPrivate.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import CoreGraphics

@_silgen_name("CGSConfigureDisplayEnabled")
func CGSConfigureDisplayEnabled(_: CGDisplayConfigRef!, _: CGDirectDisplayID, _: Bool) -> CGError

@_silgen_name("CGSGetDisplayList")
func CGSGetDisplayList(_ maxDisplays: CGDisplayCount, _ onlineDisplays: UnsafeMutablePointer<CGDirectDisplayID>!, _ displayCount: UnsafeMutablePointer<CGDisplayCount>!) -> CGDisplayErr
