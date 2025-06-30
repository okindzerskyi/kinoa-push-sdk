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
    public func buildAndAuthorize() -> URLRequest {
        var queryParams = ""
        for (key, value) in params {
            queryParams += "\(key)=\(value)&"
        }
        if (!queryParams.isEmpty) {
            queryParams.insert("?", at: queryParams.startIndex)
            queryParams.remove(at: queryParams.index(before: queryParams.endIndex))
        }
        
        let url = URL(string: baseUrl! + endpoint! + queryParams)
        var request = URLRequest(url: url!)
        request.httpMethod = httpMethod

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(SDK.instance.gameSecrets!.gameId, forHTTPHeaderField: "Game-Id")
        request.httpBody = data
        
        let auth = KinoaGameAuthUtils.calculateGameAuth(endpoint: endpoint! + queryParams, request: request);
        request.setValue(auth, forHTTPHeaderField: "Game-Auth")
        return request
    }
}
