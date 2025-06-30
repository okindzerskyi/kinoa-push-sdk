//
//  KinoaResponseBuilder.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

internal class KinoaResponseBuilder {
    public static func buildResponse(response: URLResponse) -> KinoaResponse? {
        if let httpResponse = response as? HTTPURLResponse {
            return KinoaResponse(httpResponse: httpResponse)
        }
        KinoaLogger.instance.LOG(message: "Build response failed. Response is not HTTPURLResponse.")
        return nil;
    }
    
    public static func buildResponseT<T>(_ type: T.Type, data : Data, response: URLResponse) -> KinoaResponseT<T>? where T : Decodable {
        guard let httpResponse = response as? HTTPURLResponse else {
            KinoaLogger.instance.LOG(message: "Build response failed. Response is not HTTPURLResponse.")
            return nil
        }
       
        do {
            let responseData = try JSONDecoder().decode(T.self, from: data)
            return KinoaResponseT(data: responseData, httpResponse: httpResponse)
        }catch let jsonErr {
            KinoaLogger.instance.LOG(message: "Build response failed with error: \(jsonErr)")
        }
        return nil
    }
}
