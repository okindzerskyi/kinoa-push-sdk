//
//  KinoaPushesStatus.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

/// Kinoa pushes status class.
public struct KinoaPushesStatus : Codable {
    /// `blocked` indicates if pushes are blocked on Kinoa.
    public private(set) var blocked:Bool
    
    /**
    Returns `KinoaPushesStatus`.
     
    - Parameter blocked: Indicates if pushes are blocked on Kinoa.
    */
    public init(blocked: Bool) {
        self.blocked = blocked
    }
}
