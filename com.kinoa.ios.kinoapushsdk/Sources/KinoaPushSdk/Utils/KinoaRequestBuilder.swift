//
//  KinoaRequestBuilder.swift
//  
//
//  Created by user on 05.07.2023.
//

import Foundation

internal class KinoaRequestBuilder {
    private var baseUrl:String?
    private var endpoint:String?
    private var httpMethod:String?
    private var data:Data?
    private var params = [String: Any]()
    
    public func setBaseUrl(baseUrl: String) -> KinoaRequestBuilder {
        self.baseUrl = baseUrl
        return self
    }
    
    public func setEndpoint(endpoint: String) -> KinoaRequestBuilder {
        self.endpoint = endpoint
        return self
    }
    
    public func setMethod(httpMethod: String) -> KinoaRequestBuilder {
        self.httpMethod = httpMethod
        return self
    }
    
    public func addParameter(key: String, value: Any) -> KinoaRequestBuilder {
        self.params[key] = value;
        return self
    }
    
    public func setPostData<T>(_ data: T) -> KinoaRequestBuilder where T : Encodable {
        do {
            let jsonData = try JSONEncoder().encode(data)
            self.data = jsonData
        }catch let jsonErr{
            print(jsonErr)
        }
        return self
    }
    
    @available(iOS 13.0, *)
    public func buildAndAuthorize() -> URLRequest? {
        var queryParams = ""
        for (key, value) in params {
            queryParams += "\(key)=\(value)&"
        }
        if (!queryParams.isEmpty) {
            queryParams.insert("?", at: queryParams.startIndex)
            queryParams.remove(at: queryParams.index(before: queryParams.endIndex))
        }
        
        guard let baseUrl = baseUrl, let endpoint = endpoint else {
            KinoaLogger.instance.LOG(message: "Base URL and endpoint must be set before building request")
            return nil
        }
        
        guard let url = URL(string: baseUrl + endpoint + queryParams) else {
            KinoaLogger.instance.LOG(message: "Invalid URL constructed from baseUrl: \(baseUrl), endpoint: \(endpoint), queryParams: \(queryParams)")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let gameSecrets = SDK.instance.gameSecrets else {
            KinoaLogger.instance.LOG(message: "Game secrets not initialized")
            return nil
        }
        request.setValue(gameSecrets.gameId, forHTTPHeaderField: "Game-Id")
        request.httpBody = data
        
        guard let auth = KinoaGameAuthUtils.calculateGameAuth(endpoint: endpoint + queryParams, request: request) else {
            KinoaLogger.instance.LOG(message: "Failed to calculate game auth")
            return nil
        }
        request.setValue(auth, forHTTPHeaderField: "Game-Auth")
        return request
    }
}
