//
//  KinoaBadgeCounterData.swift
//
//
//  Created by user on 10.05.2024.
//

import Foundation

internal struct KinoaBadgeCounterData : Codable {
    public private(set) var counterValue: Int
    
    public init(counterValue: Int) {
        self.counterValue = counterValue
    }
}
