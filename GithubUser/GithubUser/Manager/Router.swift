//
//  Router.swift
//  GithubUser
//
//  Created by Lam Le on 15/06/2022.
//

import Foundation
import Alamofire

typealias ParameterEncoding = Alamofire.ParameterEncoding
typealias HTTPMethod = Alamofire.HTTPMethod
typealias Parameters = Alamofire.Parameters
typealias HTTPHeaders = Alamofire.HTTPHeaders
typealias URLEncoding = Alamofire.URLEncoding

protocol Router: URLRequestConvertible, URLConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters { get }
}

extension Router {

    func asURL() throws -> URL {
        let urlString = Api.baseURL + path
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidUrl
        }
        return url
    }

    func asURLRequest() throws -> URLRequest {
        let request = try URLRequest(url: try asURL(), method: method, headers: headers)
        return try encoding.encode(request, with: parameters)
    }
}
