//
//  Request.swift
//  AFBuilder
//
//  Created by Alexander Khmelevsky on 13/03/2017.
//  Copyright © 2017 Alexander Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking

open class Request {
    private let builder: RequestBuilder
    
    init(builder:RequestBuilder) {
        self.builder = builder
    }
    
    func execute() {
        let configurator = builder.configurator
        let handlers = configurator.handlers
        let manager = configurator.manager
        
        guard handlers.filter({ !$0.requestShouldStart(builder: self.builder) }).count == 0 else {
            return
        }
        
        handlers.forEach({ $0.requestWillStart(builder:self.builder) })
        
        for handler in handlers {
            if let error = handler.prepareConfigurator(builder:self.builder, configurator: configurator) {
                handlers.forEach({ $0.failure(builder:self.builder, URLSessionDataTask: nil, error: error) })
                handlers.forEach({ $0.requestDidFinish(builder:self.builder) })
                return
            }
        }
        
        let progress: (Progress) -> Swift.Void = { progress in
            handlers.forEach({ $0.progress(builder:self.builder, progress: progress) })
        }
        
        let success: (URLSessionDataTask, Any?) -> Swift.Void = { (urlSessionDataTask, responseObject) in
            for handler in handlers {
                if let error = handler.prepareSuccess(builder:self.builder, URLSessionDataTask: urlSessionDataTask, result: responseObject) {
                    handlers.forEach({ $0.failure(builder:self.builder, URLSessionDataTask: urlSessionDataTask, error: error) })
                    handlers.forEach({ $0.requestDidFinish(builder:self.builder) })
                    return
                }
            }
            handlers.forEach({ $0.success(builder:self.builder, URLSessionDataTask: urlSessionDataTask, result: responseObject) })
            handlers.forEach({ $0.requestDidFinish(builder:self.builder) })
        }
        
        let headSuccess: (URLSessionDataTask) -> Swift.Void = { urlSessionDataTask in
            handlers.forEach({ $0.success(builder:self.builder, URLSessionDataTask: urlSessionDataTask, result: nil) })
            handlers.forEach({ $0.requestDidFinish(builder:self.builder) })
        }
        
        let failure: (URLSessionDataTask?, Error) -> Swift.Void = { (urlSessionDataTask, error) in
            handlers.forEach({ $0.failure(builder:self.builder, URLSessionDataTask: urlSessionDataTask, error: error) })
            handlers.forEach({ $0.requestDidFinish(builder:self.builder) })
        }
        
        var task: URLSessionDataTask?
        switch configurator.method {
        case .head:   task = manager.head(configurator.urlString, parameters: configurator.params, success: headSuccess, failure: failure)
        case .get:    task = manager.get(configurator.urlString, parameters: configurator.params, progress: progress, success: success, failure: failure)
        case .post:   task = manager.post(configurator.urlString, parameters: configurator.params, progress: progress, success: success, failure: failure)
        case .put:    task = manager.put(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .delete: task = manager.delete(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .patch:  task = manager.patch(configurator.urlString, parameters: configurator.params, success: success, failure: failure)
        case .postMultipartForm(let data): task = manager.post(configurator.urlString, parameters: configurator.params, constructingBodyWith: data, progress: progress, success: success, failure: failure)
        }
        
        handlers.forEach({ $0.requestStarted(builder:self.builder, task: task) })
    }
}
