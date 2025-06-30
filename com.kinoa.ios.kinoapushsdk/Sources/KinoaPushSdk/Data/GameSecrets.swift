//
//  GameSecrets.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

/// Kinoa game secrets class.
public struct GameSecrets {
    /// Kinoa game ID.
    public private(set) var gameId:String
    /// Kinoa game token.
    public private(set) var gameToken:String
    
    /**
    Returns `GameSecrets`.
     
    - Parameter gameId: Kinoa game ID.
    - Parameter gameToken: Kinoa game token.
    */
    public init(gameId: String, gameToken: String) {
        self.gameId = gameId
        self.gameToken = gameToken
    }
}
