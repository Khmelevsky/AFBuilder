//
//  HandlerProtocol.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//
import AFNetworking

@available(*, renamed:"HandlerProtocol", message: "Use HandlerProtocol")
public typealias AFBuilderHandlersProtocol = HandlerProtocol

public protocol HandlerProtocol: class {
    
    func requestShouldStart(builder:RequestBuilder) -> Bool // default: true
    func requestWillStart(builder:RequestBuilder)
    func requestDidFinish(builder:RequestBuilder)
    func requestStarted(builder:RequestBuilder, task:URLSessionDataTask?)
    
    // result state
    func progress(builder:RequestBuilder, progress:Progress)
    func success(builder:RequestBuilder, URLSessionDataTask:URLSessionDataTask, result:Any?)
    func failure(builder:RequestBuilder, URLSessionDataTask:URLSessionDataTask?, error:Error)
    
    func prepareConfigurator(builder:RequestBuilder, configurator:Configurator) -> Error?
    func prepareSuccess(builder:RequestBuilder, URLSessionDataTask:URLSessionDataTask, result:Any?) -> Error?
    
}


public extension HandlerProtocol {
    
    func requestShouldStart(builder:RequestBuilder) -> Bool { return true }
    func requestWillStart(builder:RequestBuilder) {}
    func requestDidFinish(builder:RequestBuilder) {}
    func requestStarted(builder:RequestBuilder, task:URLSessionDataTask?) {}
    
    func progress(builder:RequestBuilder, progress:Progress) {}
    func success(builder:RequestBuilder, URLSessionDataTask:Foundation.URLSessionDataTask, result:Any?) {}
    func failure(builder:RequestBuilder, URLSessionDataTask:Foundation.URLSessionDataTask?, error:Error) {}
    
    
    func prepareConfigurator(builder:RequestBuilder, configurator:Configurator) -> Error? { return nil }
    func prepareSuccess(builder:RequestBuilder, URLSessionDataTask:Foundation.URLSessionDataTask, result:Any?) -> Error? { return nil }
    
}
