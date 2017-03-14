//
//  Configurator.swift
//
//  Created by Alexandr Khmelevsky on 10/19/16.
//  Copyright © 2016 Alexandr Khmelevsky. All rights reserved.
//

import Foundation
import AFNetworking

@available(*, renamed:"Configurator", message: "Use Configurator")
public typealias AFBuildConfigurator = Configurator


public enum Method {
    case head
    case get
    case post
    case put
    case delete
    case patch
    case multipartFormData(((AFMultipartFormData) -> Swift.Void)?)
    
    @available(*, deprecated, message: "Use multipartFormData")
    case postMultipartForm(((AFMultipartFormData) -> Swift.Void)?)
}


public protocol Configurator: class {
    
    var urlString: String { get set }
    var method: Method { get set }
    var params: Any? { get set }
    var handlers: [HandlerProtocol] { get set }
    var manager: AFHTTPSessionManager { get set }
    
}



open class AFHTTPDefaultConfigurator: Configurator {
    
    open var urlString: String
    open var method: Method = .get
    open var params: Any? = nil
    open var handlers = [HandlerProtocol]()
    open var manager: AFHTTPSessionManager
    
    public init(urlString: String, manager:AFHTTPSessionManager) {
        self.urlString = urlString
        self.manager = manager
    }
}

