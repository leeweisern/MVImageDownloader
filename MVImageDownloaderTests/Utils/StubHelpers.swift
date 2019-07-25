//
//  StubHelpers.swift
//  MVImageDownloaderTests
//
//  Created by kelvin lee wei sern on 25/07/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation
import Nocilla

@discardableResult
func stub(_ url: URL, data: Data, statusCode: Int = 200, length: Int? = nil) -> LSStubResponseDSL {
    var stubResult = stubRequest("GET", url.absoluteString as NSString).andReturn(statusCode)?.withBody(data as NSData)
    if let length = length {
        stubResult = stubResult?.withHeader("Content-Length", "\(length)")
    }
    return stubResult!
}

func stub(_ url: URL, errorCode: Int) {
    let error = NSError(domain: "stubError", code: errorCode, userInfo: nil)
    return stubRequest("GET", url.absoluteString as NSString).andFailWithError(error)
}
