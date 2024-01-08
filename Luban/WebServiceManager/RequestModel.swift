//
//  RequestModel.swift
//  Noosphere
//
//  Created by King on 3/17/20.
//  Copyright © 2020 Karan. All rights reserved.
//

import UIKit


enum SignIn {
    struct Request {
        let email: String?
        let password: String?
    }
}

enum SignUp {
    struct Request {
        let name: String?
        let username: String?
        let email: String?
        let password: String?
        let confirmPassword: String?
        let loginType: Int?
        let acceptTerms: Bool?
    }
}
enum SetIntention {
    struct Request {
        let intDesc: String?
        let address: String?
        let latitude: String?
        let longitude: String?
        let name: String?
    
    }
}
enum ContactUs {
    struct Request {
        let name: String?
        let email: String?
        let message: String?
    }
}

