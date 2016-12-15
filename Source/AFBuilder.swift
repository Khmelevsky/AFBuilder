//
//  AFBuilder.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking


open class AFBuilder {
    
    // MARK: - Vars
    open var manager: AFHTTPSessionManager
    open var configurator: AFBuildConfigurator
    private var handlers = [AFBuilderHandlersProtocol]()
    
    // MARK: - Init
    public init(manager:AFHTTPSessionManager, configurator: AFBuildConfigurator) {
        self.manager = manager
        self.configurator = configurator
    }
    
    
    // MARK: - Handlers control
    open func addHandler(_ handler: AFBuilderHandlersProtocol) -> Self {
        handlers.append(handler)
        return self
    }
    
    open func removeHandler(_ handler: AFBuilderHandlersProtocol) -> Self {
        if let index = handlers.index(where: { $0 === handler }) {
            handlers.remove(at: index)
        }
        return self
    }
    
    open func removeAllHandlers() -> Self {
        handlers.removeAll()
        return self
    }
    
    // MARK: - Logic
    open func execute() {
        
        guard self.handlers.filter({ !$0.requestShouldStart(builder: self) }).count == 0 else {
            return
        }
        
        self.handlers.forEach({ $0.requestWillStart(builder:self) })
        
        for handler in self.handlers {
            if let error = handler.prepareConfigurator(builder:self, configurator: configurator) {
                self.handlers.forEach({ $0.failure(builder:self, URLSessionDataTask: nil, error: error) })
                self.handlers.forEach({ $0.requestDidFinish(builder:self) })
                return
            }
        }
        
        let progress: (Progress) -> Swift.Void = { progress in
            self.handlers.forEach({ $0.progress(builder:self, progress: progress) })
        }
        
        let success: (URLSessionDataTask, Any?) -> Swift.Void = { (urlSessionDataTask, responseObject) in
            for handler in self.handlers {
                if let error = handler.prepareSuccess(builder:self, URLSessionDataTask: urlSessionDataTask, result: responseObject) {
                    self.handlers.forEach({ $0.failure(builder:self, URLSessionDataTask: urlSessionDataTask, error: error) })
                    self.handlers.forEach({ $0.requestDidFinish(builder:self) })
                    return
                }
            }
            self.handlers.forEach({ $0.success(builder:self, URLSessionDataTask: urlSessionDataTask, result: responseObject) })
            self.handlers.forEach({ $0.requestDidFinish(builder:self) })
        }
        
        let headSuccess: (URLSessionDataTask) -> Swift.Void = { urlSessionDataTask in
            self.handlers.forEach({ $0.success(builder:self, URLSessionDataTask: urlSessionDataTask, result: nil) })
            self.handlers.forEach({ $0.requestDidFinish(builder:self) })
        }
        
        let failure: (URLSessionDataTask?, Error) -> Swift.Void = { (urlSessionDataTask, error) in
            self.handlers.forEach({ $0.failure(builder:self, URLSessionDataTask: urlSessionDataTask, error: error) })
            self.handlers.forEach({ $0.requestDidFinish(builder:self) })
        }
        
        var task: URLSessionDataTask?
        switch configurator.method {
        case .head:   task = manager.head(configurator.urlString, parameters: configurator.params, success: headSuccess, failure: failure)
        case .get:    task = manager.get(configurator.urlString, parameters: configurator.params, progress: progress, success: success, failure: failure)
        case .post:   task = manager.post(configurator.urlString, parameters: configurator.params, progress: progress, success: success, failure: failure)
        case .put:    task = manager.put(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .delete: task = manager.delete(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .patch:  task = manager.patch(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        }
        self.handlers.forEach({ $0.requestStarted(builder:self, task: task) })
        
    }
    
}
