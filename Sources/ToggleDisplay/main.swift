//
//  main.swift
//  ToggleDisplay
//
//  Created by Grigorii Entin on 27/04/2020.
//  Copyright © 2020 Grigory Entin. All rights reserved.
//

import ArgumentParser

struct DisplayUtils: ParsableCommand {

    static let configuration = CommandConfiguration(
        abstract: "Display utilities",
        subcommands: [
            Toggle.self,
            List.self
        ]
    )
}

DisplayUtils.main()
