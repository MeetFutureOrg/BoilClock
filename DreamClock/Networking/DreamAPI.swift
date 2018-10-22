//
//  DreamAPI.swift
//  DreamClock
//
//  Created by Sun on 2018/10/22.
//  Copyright © 2018 FlyWake Studio. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya_ObjectMapper

enum APIError: Error {
    case serverError(title: String, description: String)
}

protocol DreamAPI {
    
}

class API: DreamAPI {
    static let shared = API()
    
}
