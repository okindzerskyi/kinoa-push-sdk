//
//  WebRoutes.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

/// Kinoa web routes class.
public struct WebRoutes {
    /// Kinoa push service base URL.
    public private(set) var pushServiceUrl:String = "";
    
    /**
    Returns `WebRoutes`.
     
    - Parameter pushServiceUrl: Kinoa push service base URL.
    */
    public init(pushServiceUrl: String) {
        self.pushServiceUrl = pushServiceUrl
    }
}
