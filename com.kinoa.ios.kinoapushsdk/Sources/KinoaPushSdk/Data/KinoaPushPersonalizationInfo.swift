//
//  KinoaPushPersonalizationInfo.swift
//
//
//  Created by user on 09.05.2024.
//

import Foundation

public class KinoaPushPersonalizationInfo : Codable {
    public private(set) var name: String?
    public private(set) var city: String?
    public private(set) var country: String?
    public private(set) var extra1: String?
    public private(set) var extra2: String?
    public private(set) var extra3: String?
    
    public init() {
    }
    
    public func setName(name: String?) -> KinoaPushPersonalizationInfo {
        self.name = name;
        return self;
    }
    
    public func setCity(city: String?) -> KinoaPushPersonalizationInfo {
        self.city = city;
        return self;
    }
    
    public func setCountry(country: String?) -> KinoaPushPersonalizationInfo {
        self.country = country;
        return self;
    }
    
    public func setExtra1(extra1: String?) -> KinoaPushPersonalizationInfo {
        self.extra1 = extra1;
        return self;
    }
    
    public func setExtra2(extra2: String?) -> KinoaPushPersonalizationInfo {
        self.extra2 = extra2;
        return self;
    }
    
    public func setExtra3(extra3: String?) -> KinoaPushPersonalizationInfo {
        self.extra3 = extra3;
        return self;
    }
}
