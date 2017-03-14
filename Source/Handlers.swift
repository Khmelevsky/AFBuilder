//
//  Handlers.swift
//
//  Created by Alexandr Khmelevsky on 10/20/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation

public typealias SuccessClosure = (_ builder: RequestBuilder, _ URLSessionDataTask:URLSessionDataTask, _ result:Any?) -> Swift.Void
public typealias ProgressClosure = (_ builder: RequestBuilder, _ progress: Foundation.Progress) -> Swift.Void
public typealias FailureClosure = (_ builder: RequestBuilder, _ URLSessionDataTask:URLSessionDataTask?, _ error:Error) -> Swift.Void
public typealias PrepareSuccessClosure = (_ builder: RequestBuilder, _ URLSessionDataTask: URLSessionDataTask, _ result: Any?) -> Error?

public struct Handlers {
    // MARK: -
    public static func success(_ closure:@escaping SuccessClosure) -> HandlerProtocol {
        return Success(success: closure)
    }
    
    public static func progress(_ closure:@escaping ProgressClosure) -> HandlerProtocol {
        return Progress(progress: closure)
    }
    
    public static func failure(_ closure:@escaping FailureClosure) -> HandlerProtocol {
        return Failure(failure: closure)
    }
    
    public static func prepareSuccess(_ closure:@escaping PrepareSuccessClosure) -> HandlerProtocol {
        return PrepareSuccess(prepare: closure)
    }
    
 // MARK: - private
    private init(){}
}


fileprivate class Success: HandlerProtocol {
    private var closure: SuccessClosure
    
    init(success:@escaping SuccessClosure) {
        self.closure = success
    }
    
    public func success(builder: RequestBuilder, URLSessionDataTask: URLSessionDataTask, result: Any?) {
        self.closure(builder, URLSessionDataTask, result)
    }
}

fileprivate class Progress: HandlerProtocol {
    private var clousere: ProgressClosure
    
    init(progress: @escaping ProgressClosure) {
        self.clousere = progress
    }
    
    func progress(builder: RequestBuilder, progress: Foundation.Progress) {
        self.clousere(builder, progress)
    }
}

fileprivate class Failure: HandlerProtocol {
    private var clousere: FailureClosure
    
    init(failure: @escaping FailureClosure) {
        self.clousere = failure
    }
    
    func failure(builder: RequestBuilder, URLSessionDataTask: URLSessionDataTask?, error: Error) {
        self.clousere(builder, URLSessionDataTask, error)
    }
}

fileprivate class PrepareSuccess: HandlerProtocol {
    private var clousere: PrepareSuccessClosure
    
    init(prepare:@escaping PrepareSuccessClosure) {
        self.clousere = prepare
    }
    
    func prepareSuccess(builder: RequestBuilder, URLSessionDataTask: URLSessionDataTask, result: Any?) -> Error? {
        return self.clousere(builder, URLSessionDataTask, result)
    }
}

// MARK: - Deprecated
@available(*, deprecated, message: "Use Handlers.success(:)")
//public class AFBuilderSuccessHandler: HandlerProtocol {}
public func AFBuilderSuccessHandler(success:@escaping SuccessClosure) -> HandlerProtocol {
    return Handlers.success(success)
}

// Progress handler
@available(*, deprecated, message: "Use Handlers.progress(:)")
//public class AFBuilderProgressHandler: Handlers.Progress {}
public func AFBuilderProgressHandler(progress:@escaping ProgressClosure) -> HandlerProtocol {
    return Handlers.progress(progress)
}

// Failure handler
@available(*, deprecated, message: "Use Handlers.failure(:)")
//public class AFBuilderFailureHandler: Handlers.Failure {}
public func AFBuilderProgressHandler(failure:@escaping FailureClosure) -> HandlerProtocol {
    return Handlers.failure(failure)
}

// Prepare success
@available(*, deprecated, message: "Use Handlers.prepareSuccess(:)")
//public class AFBuilderPrepareSuccessHanlder: Handlers.PrepareSuccess { }
public func AFBuilderPrepareSuccessHanlder(prepare:@escaping PrepareSuccessClosure) -> HandlerProtocol {
    return Handlers.prepareSuccess(prepare)
}
