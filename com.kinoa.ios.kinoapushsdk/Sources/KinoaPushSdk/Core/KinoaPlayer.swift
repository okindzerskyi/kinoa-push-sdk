//
//  KinoaPlayer.swift
//  
//
//  Created by user on 24.07.2023.
//

import Foundation

internal class KinoaPlayer {
    public static var instance = KinoaPlayer()
    
    public private(set) var playerId:String
    
    private init() {
        playerId = ""
    }
    
    public func update(playerId: String) -> Bool {
        if (self.playerId.isEmpty || self.playerId != playerId) {
            self.playerId = playerId;
            return true;
        }
        return false;
    }

    public func isUpdated(playerId: String) -> Bool {
        return !self.playerId.isEmpty && self.playerId != playerId;
    }
}
