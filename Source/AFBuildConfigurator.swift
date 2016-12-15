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
    var method: AFHTTPSessionManagerMethod { get set }
    var params: AnyObject? { get set }
    
}


public class AFHTTPDefaultConfigurator: AFBuildConfigurator {
    
    public var urlString: String
    public var method: AFHTTPSessionManagerMethod = .get
    public var params: AnyObject? = nil
    
    public init(urlString: String) {
        self.urlString = urlString
    }
}

