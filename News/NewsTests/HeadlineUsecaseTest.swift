//
//  HeadlineUsecaseTest.swift
//  NewsTests
//
//  Created by Baboon on 25/04/2022.
//

import XCTest
import RxSwift
@testable import News

class HeadlineUsecaseTest: XCTestCase {
    
    @Injected var usecase: HeadlineUseCase
    let disposeBag = DisposeBag()
    let apiTimeout: TimeInterval = 60
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetHeadlineArticlesSuccess() throws {
        let expection = expectation(description: "Should query to get list articles success, response should have maximum of 12 articles")
        let page = 1
        usecase.getHeadlineArticles(page: page)
            .subscribe(onSuccess: { response in
                if let articles = response.articles, !articles.isEmpty && articles.count <= 12 {
                    expection.fulfill()
                } else {
                    XCTFail("Articles list should not be null, empty, or more than 12 articles")
                }
            }, onError: { error in
                XCTFail(error.localizedDescription)
            }).disposed(by: disposeBag)
        wait(for: [expection], timeout: apiTimeout)
    }
    
    func testGetHeadlineArticlesError() throws {
        let expection = expectation(description: "If page = 0, expecting this message `The page parameter cannot be less than 1. You have requested 12.` and status = `error`")
        let page = 0
        usecase.getHeadlineArticles(page: page)
            .subscribe(onSuccess: { _ in
                XCTFail("This should return status error with message")
            }, onError: { error in
                if error.localizedDescription == "The page parameter cannot be less than 1. You have requested 12." {
                    expection.fulfill()
                } else {
                    XCTFail(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
        wait(for: [expection], timeout: apiTimeout)
    }
    
    func testSearchArticlesSuccess() throws {
        let expection = expectation(description: "Should query to get list articles success, response should consist of articles related to query and maximum of 12 articles")
        let query = "Apple"
        let page = 1
        usecase.searchArticles(query: query, page: page)
            .subscribe(onSuccess: { response in
                if let articles = response.articles, !articles.isEmpty && articles.count <= 12 {
                    expection.fulfill()
                } else {
                    XCTFail("Articles list should not be null, empty, or more than 12 articles")
                }
            }, onError: { error in
                XCTFail(error.localizedDescription)
            }).disposed(by: disposeBag)
        wait(for: [expection], timeout: apiTimeout)
    }
    
    func testSearchArticlesError() throws {
        let expection = expectation(description: "If page = 0, expecting this message `The page parameter cannot be less than 1. You have requested 12.` and status = `error`")
        let query = "Apple"
        let page = 0
        usecase.searchArticles(query: query, page: page)
            .subscribe(onSuccess: { _ in
                XCTFail("This should return status error with message")
            }, onError: { error in
                if error.localizedDescription == "The page parameter cannot be less than 1. You have requested 12." {
                    expection.fulfill()
                } else {
                    XCTFail(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
        wait(for: [expection], timeout: apiTimeout)
    }
}
