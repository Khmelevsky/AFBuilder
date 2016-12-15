//
//  AFBuilder.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking


public class AFBuilder {
    
    // MARK: - Vars
    private var manager: AFHTTPSessionManager
    private var configurator: AFBuildConfigurator
    private var handlers = [AFBuilderHandlersProtocol]()
    
    // MARK: - Init
    public init(manager:AFHTTPSessionManager, configurator: AFBuildConfigurator) {
        self.manager = manager
        self.configurator = configurator
    }
    
    
    // MARK: - Handlers control
    public func addHandler(handler: AFBuilderHandlersProtocol) -> Self {
        handlers.append(handler)
        return self
    }
    
    public func removeHandler(handler: AFBuilderHandlersProtocol) -> Self {
        if let index = handlers.indexOf({ $0 === handler }) {
            handlers.removeAtIndex(index)
        }
        return self
    }
    
    public func removeAllHandlers() -> Self {
        handlers.removeAll()
        return self
    }
    
    // MARK: - Logic
    public func execute() {
        
        guard self.handlers.filter({ !$0.requestShouldStart(self) }).count == 0 else {
            return
        }
        
        self.handlers.forEach({ $0.requestWillStart(self) })
        
        for handler in self.handlers {
            if let error = handler.prepareConfigurator(self, configurator: configurator) {
                self.handlers.forEach({ $0.failure(self, URLSessionDataTask: nil, error: error) })
                self.handlers.forEach({ $0.requestDidFinish(self) })
                return
            }
        }
        
        let progress: (NSProgress) -> Swift.Void = { progress in
            self.handlers.forEach({ $0.progress(self, progress: progress) })
        }
        
        let success: (NSURLSessionDataTask, Any?) -> Swift.Void = { (urlSessionDataTask, responseObject) in
            for handler in self.handlers {
                if let error = handler.prepareSuccess(self, URLSessionDataTask: urlSessionDataTask, result: responseObject) {
                    self.handlers.forEach({ $0.failure(self, URLSessionDataTask: urlSessionDataTask, error: error) })
                    self.handlers.forEach({ $0.requestDidFinish(self) })
                    return
                }
            }
            self.handlers.forEach({ $0.success(self, URLSessionDataTask: urlSessionDataTask, result: responseObject) })
            self.handlers.forEach({ $0.requestDidFinish(self) })
        }
        
        let headSuccess: (NSURLSessionDataTask) -> Swift.Void = { urlSessionDataTask in
            self.handlers.forEach({ $0.success(self, URLSessionDataTask: urlSessionDataTask, result: nil) })
            self.handlers.forEach({ $0.requestDidFinish(self) })
        }
        
        let failure: (NSURLSessionDataTask?, NSError) -> Swift.Void = { (urlSessionDataTask, error) in
            self.handlers.forEach({ $0.failure(self, URLSessionDataTask: urlSessionDataTask, error: error) })
            self.handlers.forEach({ $0.requestDidFinish(self) })
        }
        
        var task: NSURLSessionDataTask?
        switch configurator.method {
        case .head:   task = manager.HEAD(configurator.urlString, parameters: configurator.params, success: headSuccess, failure: failure)
        case .get:    task = manager.GET(configurator.urlString, parameters: configurator.params, progress: progress, success: success, failure: failure)
        case .post:   task = manager.POST(configurator.urlString, parameters: configurator.params, progress: progress, success: success, failure: failure)
        case .put:    task = manager.PUT(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .delete: task = manager.DELETE(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .patch:  task = manager.PATCH(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        }
        self.handlers.forEach({ $0.requestStarted(self, task: task) })
        
    }
    
}
