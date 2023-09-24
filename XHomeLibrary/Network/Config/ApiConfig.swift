//
//  NetWorkingSetting.swift
//  FantasyWindow
//
//  Created by 赵翔宇 on 2022/2/21.
//

import Foundation
import Moya

public typealias HTTPRequestMethod = Moya.Method

public protocol ChunxiangTargetType: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    
}


public extension ChunxiangTargetType {
    var baseURL: URL {
        URL(string: "https://www.mxnzp.com/api")!
    }
    
    var path: String {
        let path = String(describing: self)
        return "/" + path.components(separatedBy: "(").first!
    }


    var sampleData: Data {
        "".data(using: String.Encoding.utf8)!
    }

    var task: Task {
        switch method {
        case .get:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        case .post, .put, .delete:
            return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)

        default:
            return .requestPlain
        }
    }
  
    var parameters: [String: Any]? { nil }

    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }

    // Token in Header...
    var headers: [String: String]? {
        
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
//        headers["x-lc-session"] = UserManager.shared.accessToken
        
//        if AppConfig.env == .test, UserManager.shared.accessToken.isEmpty {
//            headers["token"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTIzMzQzODkifQ.cfC85ANvZD4AES2xV-TCged03E1SYncmaWSSa6wW6c8"
//        }

        return headers
    }
}

