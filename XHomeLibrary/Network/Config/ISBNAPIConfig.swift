//
//  PlainAPIConfig.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/5.
//

import Foundation
import Moya

public protocol ISBNAPIConfig: TargetType {
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
}

extension ISBNAPIConfig {
    var baseURL: URL {
        URL(string: "http://opac.nlc.cn")!
    }

    var path: String {
        let path = String(describing: self)
        return path.components(separatedBy: "(").first!
    }

    var task: Moya.Task {
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
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
