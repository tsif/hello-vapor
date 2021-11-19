//
//  File.swift
//  
//
//  Created by Dimitris Tsiflitzis on 19/11/21.
//

import Foundation
import Fluent
import Vapor

class WebsiteRouter: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: indexHandler)
    }
    
    func indexHandler(_ req: Request) -> EventLoopFuture<View> {
        return req.view.render("index")
    }
}
