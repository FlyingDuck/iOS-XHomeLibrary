//
//  UserRedPacketAPI.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/12/7.
//

import Foundation

enum SearchAPI: ChunxiangTargetType {
    //  搜索食物的卡路里
    case searchCalory(keyword: String)
    case searchFoodEnName(keyword: String)

    var path: String {
        switch self {
        case .searchCalory:
            return "food_heat/food/search"
        case .searchFoodEnName:
            return "food_heat/food/searchFoodEnName"
        }
    }

    // 请求方法
    var method: HTTPRequestMethod {
        switch self {
        case .searchCalory:
            return .get
        case .searchFoodEnName:
            return .post
        }
    }

    // 参数
    var parameters: [String: Any]? {
        switch self {
        case .searchCalory(keyword: let keyword):
            return ["keyword": keyword,
                    "page": 1,
                    "app_id": "rgihdrm0kslojqvm",
                    "app_secret": "WnhrK251TWlUUThqaVFWbG5OeGQwdz09"]

        case .searchFoodEnName:
            return nil
        }
    }
}
