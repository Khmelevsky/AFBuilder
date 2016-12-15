//
//  AFHandlers.swift
//
//  Created by Alexandr Khmelevsky on 10/20/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation

// Success handler
open class AFBuilderSuccessHandler: AFBuilderHandlersProtocol {
    
    public typealias Clouser = (_ builder: AFBuilder, _ URLSessionDataTask:URLSessionDataTask, _ result:Any?) -> Swift.Void
    
    private var closure: AFBuilderSuccessHandler.Clouser
    
    public init(success:@escaping AFBuilderSuccessHandler.Clouser) {
        self.closure = success
    }
    
    open func success(builder: AFBuilder, URLSessionDataTask: URLSessionDataTask, result: Any?) {
        self.closure(builder, URLSessionDataTask, result)
    }
    
}

// Progress handler
open class AFBuilderProgressHandler: AFBuilderHandlersProtocol {
    
    public typealias Clouser = (_ builder: AFBuilder, _ progress: Progress) -> Swift.Void
    
    private var clousere: AFBuilderProgressHandler.Clouser
    
    public init(progress: @escaping AFBuilderProgressHandler.Clouser) {
        self.clousere = progress
    }
    
    open func progress(builder: AFBuilder, progress: Progress) {
        self.clousere(builder, progress)
    }
  
    
}

// Failure handler
open class AFBuilderFailureHandler: AFBuilderHandlersProtocol {
    
    public typealias Clouser = (_ builder: AFBuilder, _ URLSessionDataTask:URLSessionDataTask?, _ error:Error) -> Swift.Void
    
    private var clousere: AFBuilderFailureHandler.Clouser
    
    public init(failure: @escaping AFBuilderFailureHandler.Clouser) {
        self.clousere = failure
    }
    
    open func failure(builder: AFBuilder, URLSessionDataTask: URLSessionDataTask?, error: Error) {
        self.clousere(builder, URLSessionDataTask, error)
    }
    
}


// Prepare success
open class AFBuilderPrepareSuccessHanlder: AFBuilderHandlersProtocol {
    
    public typealias Clouser = (_ builder: AFBuilder, _ URLSessionDataTask: URLSessionDataTask, _ result: Any?) -> Error?
    
    private var clousere: AFBuilderPrepareSuccessHanlder.Clouser
    
    public init(prepare:@escaping AFBuilderPrepareSuccessHanlder.Clouser) {
        self.clousere = prepare
    }
    
    public func prepareSuccess(builder: AFBuilder, URLSessionDataTask: URLSessionDataTask, result: Any?) -> Error? {
        return self.clousere(builder, URLSessionDataTask, result)
    }
    
}
