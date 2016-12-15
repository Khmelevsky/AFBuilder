//
//  AFBuilderHandlerProtocol.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//
import AFNetworking


public protocol AFBuilderHandlersProtocol: class {
    
    func requestShouldStart(builder:AFBuilder) -> Bool // default: true
    func requestWillStart(builder:AFBuilder)
    func requestDidFinish(builder:AFBuilder)
    func requestStarted(builder:AFBuilder, task:URLSessionDataTask?)
    
    // result state
    func progress(builder:AFBuilder, progress:Progress)
    func success(builder:AFBuilder, URLSessionDataTask:URLSessionDataTask, result:Any?)
    func failure(builder:AFBuilder, URLSessionDataTask:URLSessionDataTask?, error:Error)
    
    func prepareConfigurator(builder:AFBuilder, configurator:AFBuildConfigurator) -> Error?
    func prepareSuccess(builder:AFBuilder, URLSessionDataTask:URLSessionDataTask, result:Any?) -> Error?
    
}


public extension AFBuilderHandlersProtocol {
    
    func requestShouldStart(builder:AFBuilder) -> Bool { return true }
    func requestWillStart(builder:AFBuilder) {}
    func requestDidFinish(builder:AFBuilder) {}
    func requestStarted(builder:AFBuilder, task:URLSessionDataTask?) {}
    
    func progress(builder:AFBuilder, progress:Progress) {}
    func success(builder:AFBuilder, URLSessionDataTask:Foundation.URLSessionDataTask, result:Any?) {}
    func failure(builder:AFBuilder, URLSessionDataTask:Foundation.URLSessionDataTask?, error:Error) {}
    
    
    func prepareConfigurator(builder:AFBuilder, configurator:AFBuildConfigurator) -> Error? { return nil }
    func prepareSuccess(builder:AFBuilder, URLSessionDataTask:Foundation.URLSessionDataTask, result:Any?) -> Error? { return nil }
    
}
