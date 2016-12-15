//
//  AFHandlers.swift
//
//  Created by Alexandr Khmelevsky on 10/20/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation

// Success handler
public class AFBuilderSuccessHandler: AFBuilderHandlersProtocol {
    
    private var closure: (builder: AFBuilder, URLSessionDataTask:NSURLSessionDataTask, result:Any?) -> Swift.Void
    
    public init(success:(builder: AFBuilder, URLSessionDataTask:NSURLSessionDataTask, result:Any?) -> Swift.Void) {
        self.closure = success
    }
    
    public func success(builder: AFBuilder, URLSessionDataTask: NSURLSessionDataTask, result: Any?) {
        self.closure(builder: builder, URLSessionDataTask: URLSessionDataTask, result: result)
    }
    
}

// Progress handler
public class AFBuilderProgressHandler: AFBuilderHandlersProtocol {
    
    private var clousere: (builder: AFBuilder, progress: NSProgress) -> Swift.Void
    
    public init(progress: (builder: AFBuilder, progress: NSProgress) -> Swift.Void) {
        self.clousere = progress
    }
    
    public func progress(builder: AFBuilder, progress: NSProgress) {
        self.clousere(builder: builder, progress: progress)
    }
  
    
}

// Failure handler
public class AFBuilderFailureHandler: AFBuilderHandlersProtocol {
    
    private var clousere: (builder: AFBuilder, URLSessionDataTask:NSURLSessionDataTask?, error:NSError) -> Swift.Void
    
    public init(failure: (builder: AFBuilder, URLSessionDataTask:NSURLSessionDataTask?, error:NSError) -> Swift.Void) {
        self.clousere = failure
    }
    
    public func failure(builder: AFBuilder, URLSessionDataTask: NSURLSessionDataTask?, error: NSError) {
        self.clousere(builder: builder, URLSessionDataTask: URLSessionDataTask, error: error)
    }
    
}


// Prepare success
public class AFBuilderPrepareSuccessHanlder: AFBuilderHandlersProtocol {
    
    private var clousere: (builder: AFBuilder, URLSessionDataTask: NSURLSessionDataTask, result: Any?) -> NSError?
    
    public init(prepare:(builder: AFBuilder, URLSessionDataTask: NSURLSessionDataTask, result: Any?) -> NSError?) {
        self.clousere = prepare
    }
    
    public func prepareSuccess(builder: AFBuilder, URLSessionDataTask: NSURLSessionDataTask, result: Any?) -> NSError? {
        return self.clousere(builder: builder, URLSessionDataTask: URLSessionDataTask, result: result)
    }
    
}
