//
//  HTTPNetworkService.swift
//  Hookers
//
//  Created by Kirill Sokolov on 2/19/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Foundation
import Alamofire


protocol NetworkRequestAdditionalParametersProviding {
    
    var parameters: Parameters { get }
    
}

protocol NetworkRequestAdditionalURLParametersProviding {
    
    var parameters: Parameters { get }
    
}

protocol NetworkRequestAdditionalHeadersProviding {
    
    var headers: HTTPHeaders { get }
    
}

final class HTTPNetworkService {
    
    private let baseURL: URL
    private let requestExecutor: NetworkRequestExecutor
    private let headerProviders: [NetworkRequestAdditionalHeadersProviding]
    private let parameterProviders: [NetworkRequestAdditionalParametersProviding]
    private let additionalURLParameterProviders: [NetworkRequestAdditionalURLParametersProviding]
    
    private var additionalParameters: Parameters {
        return parameterProviders.reduce([:]) { result, provider -> Parameters in
            return result + provider.parameters
        }
    }
    
    private var additionalHeaders: HTTPHeaders {
        return headerProviders.reduce([:], { result, provider -> HTTPHeaders in
            return result + provider.headers
        })
    }
    
    private var additionalURLParameters: Parameters {
        return additionalURLParameterProviders.reduce([:]) { result, provider -> Parameters in
            return result + provider.parameters
        }
    }
    
    init(baseURL: URL,
         requestExecutor: NetworkRequestExecutor,
         headerProviders: [NetworkRequestAdditionalHeadersProviding] = [],
         parameterProviders: [NetworkRequestAdditionalParametersProviding] = [],
         additionalURLParameterProviders: [NetworkRequestAdditionalURLParametersProviding] = []) {
        self.baseURL = baseURL
        self.requestExecutor = requestExecutor
        self.headerProviders = headerProviders
        self.parameterProviders = parameterProviders
        self.additionalURLParameterProviders = additionalURLParameterProviders
    }
    
    public func executeRequest(
        endpoint: String?,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkResponse) -> Void) {
        
        let parameters = parameters ?? [:]
        let headers = headers ?? [:]
        
        let url = makeURL(withBaseURL: baseURL, endpoint: endpoint, parameters: additionalURLParameters)
        
        let encoding = (method == .get) ? ParameterEncoding.URL : ParameterEncoding.JSON
        
        let allParameters = parameters + additionalParameters
        
        self.requestExecutor.executeRequest(url,
                                            method: method,
                                            parameters: allParameters,
                                            encoding: encoding,
                                            headers: headers + additionalHeaders) { data, error, statusCode, httpURLResponse in
                                                self.handleResponse(data: data,
                                                                    error: error,
                                                                    statusCode: statusCode,
                                                                    httpURLResponse: httpURLResponse,
                                                                    completion: completion)
        }
    }
    
    func executeRequestWithMultipartData(
        _ multipartFormData: @escaping (MultipartFormData) -> Void,
        endpoint: String?,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        completion: @escaping (NetworkResponse) -> Void) {
        
        let headers = headers ?? [:]
        
        let url = makeURL(withBaseURL: baseURL, endpoint: endpoint, parameters: additionalURLParameters)
        
        self.requestExecutor.executeRequestWithMultipartData(multipartFormData,
                                                             url: url,
                                                             method: method,
                                                             headers: headers + additionalHeaders) { json, error, statusCode, httpURLResponse in
                                                                self.handleMultipartResponse(json: json,
                                                                                             error: error,
                                                                                             statusCode: statusCode,
                                                                                             httpURLResponse: httpURLResponse,
                                                                                             completion: completion)
        }
    }
    
    private func makeURL(withBaseURL baseURL: URL, endpoint: String?, parameters: Parameters) -> URL {
        var url = (endpoint != nil && !endpoint!.isEmpty) ? URL(string: baseURL.absoluteString + endpoint!) : baseURL
        
        if !parameters.isEmpty, var path = url?.absoluteString {
            for (index, parameter) in parameters.enumerated() {
                path += index == 0 ? "?" : "&"
                path += parameter.key + "=" + String(describing: parameter.value)
            }
            url = URL(string: path)
        }
        
        return url!
    }
    
    private func handleResponse(data: Data?,
                                error: Error?,
                                statusCode: Int?,
                                httpURLResponse: HTTPURLResponse?,
                                completion: @escaping (NetworkResponse) -> Void) {
        if let error = error {
            let response = NetworkResponse(result: nil, networkInnerError: nil, requestId: nil, action: nil, data: data, httpStatusCode: statusCode, error: error)
            completion(response)
        } else {
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
                print("http response = ", json?.description ?? "")
                if let json = json,// json["reqId"] != nil,
                    let response = NetworkResponseMapper.JSONtoAny(json) {
                    completion(response)
                }
            } else {
                completion(NetworkResponse(result: nil, networkInnerError: nil, requestId: nil, action: nil, data: data, httpStatusCode: statusCode, error: error))
            }
        }
    }
    
    private func handleMultipartResponse(json: JSON?,
                                         error: Error?,
                                         statusCode: Int?,
                                         httpURLResponse: HTTPURLResponse?,
                                         completion: @escaping (NetworkResponse) -> Void) {
        if let error = error {
            let response = NetworkResponse(result: nil, networkInnerError: nil, requestId: nil, action: nil, data: nil, httpStatusCode: statusCode, error: error)
            completion(response)
        } else {
            if let json = json {
                print("http response = ", json.description)
                if json["reqId"] != nil,
                    let response = NetworkResponseMapper.JSONtoAny(json) {
                    completion(response)
                }
            } else {
                completion(NetworkResponse(result: nil, networkInnerError: nil, requestId: nil, action: nil, data: nil, httpStatusCode: statusCode, error: error))
            }
        }
    }
    
}
