//
//  ToggleCommand.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import CoreGraphics
import ArgumentParser

extension DisplayUtils {

    struct Toggle: ParsableCommand {

        @Argument(help: "Display ID")
        var displayID: CGDirectDisplayID

        @Flag(name: .shortAndLong, help: "Whether to toggle display on or off")
        var on: Bool

        func run() throws {
            var config: CGDisplayConfigRef?

            try withCGError { CGBeginDisplayConfiguration(&config) }

            do {
                try withCGError { CGSConfigureDisplayEnabled(config, displayID, on) }

                try withCGError { CGCompleteDisplayConfiguration(config, .permanently) }
            } catch {
                try withCGError { CGCancelDisplayConfiguration(config) }
            }
        }
    }
}
