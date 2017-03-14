//
//  RequestManager.swift
//  AFBuilder
//
//  Created by Alexander Khmelevsky on 14/03/2017.
//  Copyright © 2017 Alexander Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking

open class RequestManager: AFHTTPSessionManager {
    
    public var defaultHandlers = [HandlerProtocol]()
    public var defaultParams = Dictionary<String,Any>()
    public var defaultMethod = Method.get
    
    func builder(url: String, clouser: ((Configurator) -> Void)? = nil) -> RequestBuilder {
        let configurator = AFHTTPDefaultConfigurator(urlString: url, manager:self)
        configurator.handlers = self.defaultHandlers
        configurator.params = self.defaultParams
        configurator.method = self.defaultMethod
        clouser?(configurator)
        return RequestBuilder(manager: self, configurator: configurator)
    }
    
}
