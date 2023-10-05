//
//  ISBNAPI.swift
//  XHomeLibrary
//
//  Created by dongshujin on 2023/10/5.
//

import Moya
import SwiftUI

enum ISBNAPI: ISBNAPIConfig {
    case fetchRealURL
    case fetchBookInfo(token: String, code: String)
}

extension ISBNAPI {
    var parameters: [String: Any]? {
        switch self {
        case .fetchRealURL:
            return nil
        case .fetchBookInfo(token: _, code: let code):
            // func=find-b&find_code=ISB&request=9787572004353&local_base=NLC01&filter_code_1=WLN&filter_request_1=&filter_code_2=WYR&filter_request_2=&filter_code_3=WYR&filter_request_3=&filter_code_4=WFM&filter_request_4=&filter_code_5=WSL&filter_request_5=
            return ["func": "find-b",
                    "find_code": "ISB",
                    "request": code,
                    "local_base": "NLC01",
                    "filter_code_1": "WLN",
                    "filter_request_1": "",
                    "filter_code_2": "WYR",
                    "filter_request_2": "",
                    "filter_code_3": "WYR",
                    "filter_request_3": "",
                    "filter_code_4": "WFM",
                    "filter_request_4": "",
                    "filter_code_5": "WSL",
                    "filter_request_5": ""]
        }
    }

    var path: String {
        switch self {
        case .fetchRealURL:
            return "/F"
        case .fetchBookInfo(token: let token, code: _):
            return "/F/\(token)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchRealURL:
            return .get
        case .fetchBookInfo(token: _, code: _):
            return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case .fetchRealURL:
            var headers: [String: String] = [:]
            headers["Cache-Control"] = "max-age=0"
            headers["Upgrade-Insecure-Requests"] = "1"
            headers["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36"
            headers["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
            headers["Accept-Encoding"] = "gzip, deflate"
            headers["Accept-Language"] = "zh-CN,zh;q=0.9,en;q=0.8"
            return headers

        default:
            let headers: [String: String] = [:]
            return headers
        }
    }
}
