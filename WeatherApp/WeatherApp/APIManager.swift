//
//  APIManager.swift
//  WeatherApp
//
//  Created by Admin on 18/02/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONComplitionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session:URLSession { get }

    func JSONTaskWith(request: URLRequest, complitionHandler: JSONComplitionHandler) -> JSONTask
    
    func fetch<T>(request: URLRequest, parse: ([String: AnyObject]) -> T?, complitionHandler: (APIResult<T>) -> Void)
    
    init(sessionConfiguration: URLSessionConfiguration)
}
