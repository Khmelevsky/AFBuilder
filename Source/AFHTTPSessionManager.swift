//
//  AFHTTPSessionManager.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking


public enum AFHTTPSessionManagerMethod {
    
    case head
    case get
    case post
    case put
    case delete
    case patch
    
}


extension AFHTTPSessionManager {
    
    public func builder(withUrlString url: String, clouser:(AFBuildConfigurator) -> Swift.Void) -> AFBuilder {
        let configurator = AFHTTPDefaultConfigurator(urlString: url)
        clouser(configurator)
        return AFBuilder(manager: self, configurator: configurator)
    }
    
    public func builder(withConfigurator configurator:AFBuildConfigurator) -> AFBuilder {
        return AFBuilder(manager: self, configurator: configurator)
    }
    
}
