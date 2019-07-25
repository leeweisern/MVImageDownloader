//
//  MVImageDownloaderTests.swift
//  MVImageDownloaderTests
//
//  Created by kelvin lee wei sern on 25/07/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import XCTest
import Nocilla

@testable import MVImageDownloader

class ImageDownloaderTests: XCTestCase {
    
    var mindValleyManager: MindValleyManager!
    
    override class func setUp() {
        super.setUp()
        LSNocilla.sharedInstance().start()
    }
    
    override class func tearDown() {
        LSNocilla.sharedInstance().stop()
        super.tearDown()
    }
    
    override func setUp() {
        super.setUp()
        
        mindValleyManager = MindValleyManager.shared
    }
    
    override func tearDown() {
        LSNocilla.sharedInstance().clearStubs()
        mindValleyManager = nil
        super.tearDown()
    }
    
    func testDownloadAnImage() {
        let exp = expectation(description: #function)
        
        let url = testURLs[0]
        stub(url, data: testImageData)
        mindValleyManager.retrieveImage(with: url) { (result) in
            if let image = try? result.get() {
                XCTAssertNotNil(image)
                exp.fulfill()
            }
        }

        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testDownloadMultipleImages() {
        let exp = expectation(description: #function)
        let group = DispatchGroup()
        
        for url in testURLs {
            group.enter()
            stub(url, data: testImageData)
            mindValleyManager.retrieveImage(with: url) { (result) in
                if let image = try? result.get() {
                    XCTAssertNotNil(image)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main, execute: exp.fulfill)
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testDownloadAnImageWithMultipleCallback() {
        let exp = expectation(description: #function)
        
        let group = DispatchGroup()
        let url = testURLs[0]
        stub(url, data: testImageData)
        
        for _ in 0...5 {
            group.enter()
            mindValleyManager.retrieveImage(with: url) { (result) in
                if let image = try? result.get() {
                    XCTAssertNotNil(image)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main, execute: exp.fulfill)
        waitForExpectations(timeout: 3, handler: nil)
    }
}

extension ImageDownloaderTests: ImageDownloaderDelegate {
    func imageDownloader(_ downloader: ImageDownloader, didDownload data: Data, for url: URL) -> Data? {
        return nil
    }
}


