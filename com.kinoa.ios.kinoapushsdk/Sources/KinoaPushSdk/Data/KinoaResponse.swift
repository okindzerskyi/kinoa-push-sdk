//
//  KinoaResponse.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

/// Kinoa reponse class.
public class KinoaResponse {
    /// HTTP URL Reponse.
    public private(set) var httpResponse: HTTPURLResponse
    
    /**
    Returns `KinoaResponse`.
     
    - Parameter httpResponse: HTTP URL Reponse.
    */
    public init(httpResponse: HTTPURLResponse) {
        self.httpResponse = httpResponse
    }
}

/// Kinoa generic response class.
public class KinoaResponseT<T> : KinoaResponse {
    /// Generic data.
    public private(set) var data: T
    
    /**
    Returns `KinoaResponse<T>`.
     
    - Parameter data: Generic data .
    - Parameter httpResponse: HTTP URL Reponse.
    */
    public init(data: T, httpResponse: HTTPURLResponse) {
        self.data = data
        super.init(httpResponse: httpResponse)
    }
}
