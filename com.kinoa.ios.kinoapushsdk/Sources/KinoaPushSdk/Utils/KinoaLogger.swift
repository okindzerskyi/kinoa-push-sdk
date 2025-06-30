//
//  KinoaLogger.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

internal class KinoaLogger {
    private var source = "KinoaPushSdk"
    
    public static var instance = KinoaLogger()
    
    private init(){
    }
    
    public func LOG(message: String) {
        print("[\(Date())] [\(source)] \(message)")
    }
}
