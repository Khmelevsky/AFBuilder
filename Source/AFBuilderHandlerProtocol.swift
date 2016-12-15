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
    func requestStarted(builder:AFBuilder, task:NSURLSessionDataTask?)
    
    // result state
    func progress(builder:AFBuilder, progress:NSProgress)
    func success(builder:AFBuilder, URLSessionDataTask:NSURLSessionDataTask, result:Any?)
    func failure(builder:AFBuilder, URLSessionDataTask:NSURLSessionDataTask?, error:NSError)
    
    func prepareConfigurator(builder:AFBuilder, configurator:AFBuildConfigurator) -> NSError?
    func prepareSuccess(builder:AFBuilder, URLSessionDataTask:NSURLSessionDataTask, result:Any?) -> NSError?
    
}


public extension AFBuilderHandlersProtocol {
    
    func requestShouldStart(builder:AFBuilder) -> Bool { return true }
    func requestWillStart(builder:AFBuilder) {}
    func requestDidFinish(builder:AFBuilder) {}
    func requestStarted(builder:AFBuilder, task:NSURLSessionDataTask?) {}
    
    func progress(builder:AFBuilder, progress:NSProgress) {}
    func success(builder:AFBuilder, URLSessionDataTask:NSURLSessionDataTask, result:Any?) {}
    func failure(builder:AFBuilder, URLSessionDataTask:NSURLSessionDataTask?, error:NSError) {}
    
    
    func prepareConfigurator(builder:AFBuilder, configurator:AFBuildConfigurator) -> NSError? { return nil }
    func prepareSuccess(builder:AFBuilder, URLSessionDataTask:NSURLSessionDataTask, result:Any?) -> NSError? { return nil }
    
}
