//
//  NetworkRequestExecutor.swift
//  Hookers
//
//  Created by Kirill Sokolov on 2/19/18.
//  Copyright © 2018 Hookers. All rights reserved.
//

import Alamofire

enum HTTPMethod {
    case get, post, delete, patch, put
}

enum ParameterEncoding {
    case URL, JSON
}

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

/// A dictionary of headers to apply to a `URLRequest`.
public typealias HTTPHeaders = [String: String]


final class NetworkRequestExecutor {
    
    private let sessionManager: Alamofire.SessionManager
    private let backgroundSessionManager: Alamofire.SessionManager
    
    init(sessionManager: Alamofire.SessionManager = .default, backgroundSessionManager: Alamofire.SessionManager = .default) {
        self.sessionManager = sessionManager
        self.backgroundSessionManager = backgroundSessionManager
    }
    
    public func executeRequest(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = ParameterEncoding.JSON,
        headers: HTTPHeaders? = nil,
        completion: @escaping (_ data: Data?, _ error: Error?, _ statusCode: Int?, _ httpURLResponse: HTTPURLResponse?) -> Void) {
        
        let alamofireMethod = httpMethodToAlamofire(method)
        let alamofireEncoding = parameterEncodingToAlamofire(encoding)
        
        sessionManager.request(url.asURL,
                               method: alamofireMethod,
                               parameters: parameters,
                               encoding: alamofireEncoding,
                               headers: headers).responseData { dataResponse in
                                var statusCode = dataResponse.response?.statusCode
                                switch (dataResponse.result) {
                                case .failure(let error):
                                    if error._code == NSURLErrorTimedOut {
                                        statusCode = HTTPStatusCode.gatewayTimeout_504
                                    }
                                default: break
                                }
                                completion(dataResponse.result.value, dataResponse.error, statusCode, dataResponse.response)
        }
    }
    
    public func executeRequestWithMultipartData(
        _ multipartFormData: @escaping (MultipartFormData) -> Void,
        url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        completion: @escaping (_ json: JSON?, _ error: Error?, _ statusCode: Int?, _ httpURLResponse: HTTPURLResponse?) -> Void) {
        let alamofireMethod = httpMethodToAlamofire(method)
        
        backgroundSessionManager.upload(multipartFormData: multipartFormData,
                                        to: url.asURL,
                                        method: alamofireMethod,
                                        headers: headers,
                                        encodingCompletion: { encodingResult in
                                            var statusCode: Int?
                                            switch encodingResult {
                                            case .success(let request, _, _):
                                                statusCode = request.response?.statusCode
                                
                                                request.responseJSON(completionHandler: { response in
                                                    switch (response.result) {
                                                    case .failure(let error):
                                                        if error._code == NSURLErrorTimedOut {
                                                            statusCode = HTTPStatusCode.gatewayTimeout_504
                                                        }
                                                    default: break
                                                    }
                                                    completion(response.result.value as? JSON, response.error, statusCode, response.response)
                                                })
                                                
                                                // RS: TODO: maybe use later upload progress
                                    
            //                                    if let progressHandler = multipartRequest.progressHandler {
            //                                        request = request.uploadProgress { progress in
            //                                            progressHandler(progress)
            //                                        }
            //                                    }
                                    
                                            case .failure(let error):
                                                if error._code == NSURLErrorTimedOut {
                                                    statusCode = HTTPStatusCode.gatewayTimeout_504
                                                }
                                              completion(nil, nil, statusCode, nil)
                                            }
            })
    }
    
}

extension NetworkRequestExecutor {
    
    fileprivate func httpMethodToAlamofire(_ httpMethod: HTTPMethod) -> Alamofire.HTTPMethod {
        switch httpMethod {
        case .get:
            return Alamofire.HTTPMethod.get
        case .post:
            return Alamofire.HTTPMethod.post
        case .put:
            return Alamofire.HTTPMethod.put
        case .patch:
            return Alamofire.HTTPMethod.patch
        case .delete:
            return Alamofire.HTTPMethod.delete
        }
    }
    
    fileprivate func parameterEncodingToAlamofire(_ encoding: ParameterEncoding) -> Alamofire.ParameterEncoding {
        switch encoding {
        case .JSON:
            return Alamofire.JSONEncoding.default
        case .URL:
            return Alamofire.URLEncoding.default
        }
    }
    
}
