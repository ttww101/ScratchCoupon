//
//  MyService.swift
//  UUBuy
//
//  Created by Jack on 2019/6/13.
//  Copyright © 2019 com.timi.test.test. All rights reserved.
//

import Foundation
import Moya

enum API {
    case getCatelory
    case getProducts(id: Int)
    case getProduct(id: Int)
    case searchGood(keyword: String)
}

// MARK: - TargetType Protocol Implementation
extension API: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL { return URL(string: "http://www.szzzbao.cn")! }
    var path: String {
        switch self {
        case .getCatelory:
            return ""
        case .getProducts:
            return "/category.php"
        case .getProduct:
            return "/goods.php"
        case .searchGood:
            return "/search.php"
        }
        
        
    }
    var method: Moya.Method {
        switch self {
        case .getCatelory:
            return .get
        case .getProducts:
            return .get
        case .getProduct:
            return .get
        case .searchGood:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getCatelory:
            return .requestPlain
        case .getProducts(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.default)
        case .getProduct(let id):
            return .requestParameters(parameters: ["id":id], encoding: URLEncoding.default)
        case .searchGood(let keyword):
            return .requestParameters(parameters: ["keywords":keyword], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


protocol MoyaCacheable {
    typealias MoyaCacheablePolicy = URLRequest.CachePolicy
    var cachePolicy: MoyaCacheablePolicy { get }
}

final class MoyaCacheablePlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let moyaCachableProtocol = target as? MoyaCacheable {
            var cachableRequest = request
            cachableRequest.cachePolicy = moyaCachableProtocol.cachePolicy
            return cachableRequest
        }
        return request
    }
}

extension API: MoyaCacheable {
    var cachePolicy: MoyaCacheablePolicy {
        switch self {
        case .getCatelory:
            return .returnCacheDataElseLoad
        case .getProducts:
            return .returnCacheDataElseLoad
        case .getProduct:
            return .returnCacheDataElseLoad
        default:
            return .reloadIgnoringLocalAndRemoteCacheData
        }
    }
}
