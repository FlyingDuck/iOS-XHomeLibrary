//
//  WarningPlugin.swift
//  FantasyChat
//
//  Created by 赵翔宇 on 2022/8/1.
//

import Foundation
import Moya

/// 通用网络插件
public class WarningPlugin: PluginType {
    /// 开始请求字典

    public init() {}

    /// 即将发送请求
    public func willSend(_: RequestType, target: TargetType) {
        #if DEBUG
            // 设置当前时间

        #endif
    }

    /// 收到请求时
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success:
            if result.HttpCode != 200 &&  result.HttpCode != 400{
              
            }
            if result.HttpCode == 400 {
              
            }
        case let .failure(error):
           print(error)
        }
    }
}

/// 网络状态协议
protocol NetworkStatusProtocol {
    func isReachable() -> Bool
}

extension NetworkStatusProtocol {
    /// 返回一个布尔值,用于实时监测网络状态
    func isReachable() -> Bool {
        var res = false
        let netManager = NetworkReachabilityManager()
        if netManager?.status == .reachable(.ethernetOrWiFi) || netManager?.status == .reachable(.cellular) { res = true }
        return res
    }
}
