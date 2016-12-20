//
//  AFBuildConfigurator.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking


public protocol AFBuildConfigurator: class {
    
    var urlString: String { get set }
    var method: AFHTTPSessionManager.Method { get set }
    var params: Any? { get set }
    
}


open class AFHTTPDefaultConfigurator: AFBuildConfigurator {
    
    open var urlString: String
    open var method: AFHTTPSessionManager.Method = .get
    open var params: Any? = nil
    
    public init(urlString: String) {
        self.urlString = urlString
    }
}

