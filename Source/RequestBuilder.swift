//
//  RequestBuilder.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking

@available(*, renamed:"Configurator", message: "Use Handlers.success(:)")
public typealias AFBuilder = RequestBuilder

open class RequestBuilder {
    
    // MARK: - Vars
    private(set) open var configurator: Configurator
    
    // MARK: - Init
    public init(manager:AFHTTPSessionManager, configurator: Configurator) {
        configurator.manager = manager
        self.configurator = configurator
    }
    
    // MARK: - Logic
    open func execute() {
        Request(builder: self).execute()
    }
    
}

// MARK: - Handlers control
extension RequestBuilder {
    
    open func addHandler(_ handler: HandlerProtocol) -> Self {
        configurator.handlers.append(handler)
        return self
    }
    
    open func removeHandler(_ handler: HandlerProtocol) -> Self {
        if let index = configurator.handlers.index(where: { $0 === handler }) {
            configurator.handlers.remove(at: index)
        }
        return self
    }
    
    open func removeAllHandlers() -> Self {
        configurator.handlers.removeAll()
        return self
    }
}
